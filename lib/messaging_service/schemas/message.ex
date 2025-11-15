defmodule MessagingService.Schemas.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :type, Ecto.Enum, values: [:sms, :mms, :email]
    field :body, :string
    field :attachments, {:array, :string}

    belongs_to :conversation, MessagingService.Schemas.Conversation
    belongs_to :from, MessagingService.Schemas.Contact
    belongs_to :to, MessagingService.Schemas.Contact

    timestamps()
  end

  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:type, :body, :attachments, :conversation_id, :from_id, :to_id])
    |> validate_required([:type, :body, :conversation_id, :from_id, :to_id])
  end
end
