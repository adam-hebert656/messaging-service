defmodule MessagingService.Repo.Migrations.CreateConversationsTable do
  use Ecto.Migration

  def change do
    create table(:conversations) do
      timestamps()
    end

    alter table(:messages) do
      add :conversation_id, references(:conversations)
    end

    create index(:conversations, :inserted_at)

    create index(:messages, :conversation_id)
  end
end
