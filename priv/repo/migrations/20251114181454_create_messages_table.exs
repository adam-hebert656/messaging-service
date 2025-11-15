defmodule MessagingService.Repo.Migrations.CreateMessagesTable do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :type, :string
      add :body, :string
      add :attachments, {:array, :string}

      timestamps()
    end
  end
end
