defmodule MessagingService.Repo.Migrations.CreateMessagesTable do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :type, :string
      add :body, :string
      add :attachments, {:array, :string}
      add :provider_message_id, :string

      timestamps()
    end

    create index(:messages, :type)
    create index(:messages, :inserted_at)
  end
end
