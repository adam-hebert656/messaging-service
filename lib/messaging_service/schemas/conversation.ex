defmodule MessagingService.Schemas.Conversation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "conversations" do
    many_to_many :conversations, MessagingService.Schemas.Conversation,
      join_through: "contact_conversations"

    has_many :messages, MessagingService.Schemas.Message
  end

  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [])
  end
end
