defmodule MessagingService.Messages do
  alias MessagingService.Providers.Sms
  alias MessagingService.Providers.Mms
  alias MessagingService.Providers.Email
  alias MessagingService.Contacts
  alias MessagingService.Schemas.Message
  alias MessagingService.Repo

  def send_message("sms", message) do
    resp = Sms.send(message)

    case resp do
      {:ok, :sent} ->
        save_message_to_db(message)
        {:ok, message}

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
        {:ok, message}

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
        {:ok, message}

      {:error, reason} ->
        IO.inspect("Failed to send Email: #{reason}")
        {:error, reason}
    end
  end

  def send_message(_, _message) do
    IO.inspect("Unknown message type")
    {:error, :unknown_type}
  end

  def ingest_message(message) do
    {:ok, _message} = save_message_to_db(message)
  end

  defp save_message_to_db(message) do
    contacts = Contacts.find_or_create_contact_for_message(message)

    conversation =
      MessagingService.Conversations.find_or_create_conversation_by_contacts(contacts)

    [from, to] = contacts

    %Message{}
    |> Message.changeset(%{
      from_id: from.id,
      to_id: to.id,
      conversation_id: conversation.id,
      body: Map.get(message, "body", ""),
      type: String.to_atom(Map.get(message, "type")),
      attachments: Map.get(message, "attachments", []),
      provider_message_id: Map.get(message, "provider_message_id", nil)
    })
    |> Repo.insert()
  end
end
