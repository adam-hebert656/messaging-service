defmodule MessagingService.Repo.Migrations.CreateContactsTable do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :email, :string
      add :phone, :string

      timestamps()
    end

    create constraint(:contacts, :validate_email_or_phone,
             check:
               "(phone IS NOT NULL AND email IS NULL) OR (email IS NOT NULL AND phone IS NULL)"
           )

    create unique_index(:contacts, [:email])
    create unique_index(:contacts, [:phone])

    alter table(:messages) do
      add :from_id, references(:contacts)
      add :to_id, references(:contacts)
    end
  end
end
