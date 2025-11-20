defmodule MessagingService.Conversations do
  alias MessagingService.Repo
  alias MessagingService.Schemas.Conversation
  import Ecto.Query
  import Ecto.Changeset

  def find_or_create_conversation_by_contacts(contacts) do
    contact_ids = Enum.map(contacts, & &1.id)

    conversation =
      Conversation
      |> join(:inner, [c], contact in assoc(c, :contacts))
      |> where([c, contact], contact.id in ^contact_ids)
      |> group_by([c], c.id)
      |> having([c, contact], count(contact.id) == 2)
      |> Repo.one()

    if conversation do
      conversation
    else
      changeset =
        %Conversation{}
        |> change()
        |> put_assoc(:contacts, contacts)

      {:ok, conversation} = Repo.insert(changeset)
      conversation
    end
  end

  def get_all_conversations() do
    Repo.all(Conversation)
    |> Repo.preload(:contacts)
    |> Repo.preload(:messages)
  end

  def get_conversation!(id) do
    Repo.get!(Conversation, id)
    |> Repo.preload(:contacts)
    |> Repo.preload(:messages)
  end
end
