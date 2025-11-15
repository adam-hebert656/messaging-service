defmodule MessagingService.Repo.Migrations.CreateContactConversationsTable do
  use Ecto.Migration

  def change do
    create table(:contact_conversations) do
      add :contact_id, references(:contacts)
      add :conversation_id, references(:conversations)
    end

    create unique_index(:contact_conversations, [:contact_id, :conversation_id])
  end
end
