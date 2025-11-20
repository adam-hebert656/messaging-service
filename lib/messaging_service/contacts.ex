defmodule MessagingService.Contacts do
  alias MessagingService.Schemas.Contact
  alias MessagingService.Repo
  import Ecto.Query

  def find_or_create_contact_for_message(%{"from" => from, "to" => to, "type" => type}) do
    case type do
      "sms" ->
        {:ok, from_contact} = find_or_create_contact_by_phone(from)
        {:ok, to_contact} = find_or_create_contact_by_phone(to)
        [from_contact, to_contact]

      "mms" ->
        {:ok, from_contact} = find_or_create_contact_by_phone(from)
        {:ok, to_contact} = find_or_create_contact_by_phone(to)
        [from_contact, to_contact]

      "email" ->
        {:ok, from_contact} = find_or_create_contact_by_email(from)
        {:ok, to_contact} = find_or_create_contact_by_email(to)
        [from_contact, to_contact]
    end
  end

  defp find_or_create_contact_by_phone(phone) do
    contact =
      Contact
      |> where([c], c.phone == ^phone)
      |> Repo.one()

    if contact do
      {:ok, contact}
    else
      %Contact{phone: phone}
      |> Repo.insert()
    end
  end

  defp find_or_create_contact_by_email(email) do
    contact =
      Contact
      |> where([c], c.email == ^email)
      |> Repo.one()

    if contact do
      {:ok, contact}
    else
      %Contact{email: email}
      |> Repo.insert()
    end
  end
end
