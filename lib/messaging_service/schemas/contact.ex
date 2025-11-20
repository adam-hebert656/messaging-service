defmodule MessagingService.Schemas.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :email, :phone]}

  schema "contacts" do
    field :email, :string
    field :phone, :string

    many_to_many :conversations, MessagingService.Schemas.Conversation,
      join_through: "contact_conversations"

    timestamps()
  end

  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:email, :phone])
    |> unique_constraint([:email, :phone])
    |> validate_one_of_phone_or_email()
  end

  defp validate_one_of_phone_or_email(changeset) do
    fields = [:email, :phone]
    count = Enum.count(fields, fn field -> !is_nil(get_field(changeset, field)) end)

    case count do
      1 ->
        changeset

      _ ->
        Enum.reduce(fields, changeset, fn field, changeset ->
          add_error(changeset, field, "only one of either phone or email must be present")
        end)
    end
  end
end
