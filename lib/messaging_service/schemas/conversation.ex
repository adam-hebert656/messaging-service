defmodule MessagingService.Schemas.Conversation do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :contacts, :messages]}

  schema "conversations" do
    many_to_many :contacts, MessagingService.Schemas.Contact,
      join_through: "contact_conversations"

    has_many :messages, MessagingService.Schemas.Message

    timestamps()
  end

  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [])
  end
end
