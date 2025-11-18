defmodule MessagingService.Messages do
  alias MessagingService.Providers.Sms
  alias MessagingService.Providers.Mms
  alias MessagingService.Providers.Email
  alias MessagingService.Repo

  def send_message("sms", message) do
    resp = Sms.send(message)

    case resp do
      {:ok, :sent} ->
        save_message_to_db(message)
        {:ok, :sent}

      {:error, reason} ->
        IO.inspect("Failed to send SMS: #{reason}")
        {:error, reason}
    end
  end

  def send_message("mms", message) do
    resp = Mms.send(message)

    case resp do
      {:ok, :sent} ->
        save_message_to_db(message)
        {:ok, :sent}

      {:error, reason} ->
        IO.inspect("Failed to send MMS: #{reason}")
        {:error, reason}
    end
  end

  def send_message("email", message) do
    resp = Email.send(message)

    case resp do
      {:ok, :sent} ->
        save_message_to_db(message)
        {:ok, :sent}

      {:error, reason} ->
        IO.inspect("Failed to send Email: #{reason}")
        {:error, reason}
    end
  end

  def send_message(_, _message) do
    IO.inspect("Unknown message type")
    {:error, :unknown_type}
  end

  defp save_message_to_db(message) do
    save_contact_info(message)
  end

  defp save_contact_info(%{"from" => from, "to" => to, "type" => type}) do
    if type in ["sms", "mms"] do
      res = Repo.transact(fn ->
        from = Repo.insert(%MessagingService.Schemas.Contact{phone: from}, on_conflict: :nothing)
        to = Repo.insert(%MessagingService.Schemas.Contact{phone: to}, on_conflict: :nothing)
        {:ok, {from, to}}
      end)
      case res do
        {:ok, _} -> {:ok, :saved}
        {:error, reason} -> {:error, reason}
      end
    else
      Repo.insert_all(
        MessagingService.Schemas.Contact,
        [
          %{
            email: from,
            inserted_at: NaiveDateTime.utc_now(:second),
            updated_at: NaiveDateTime.utc_now(:second)
          },
          %{
            email: to,
            inserted_at: NaiveDateTime.utc_now(:second),
            updated_at: NaiveDateTime.utc_now(:second)
          }
        ],
        on_conflict: :nothing
      )
    end
  end
end
