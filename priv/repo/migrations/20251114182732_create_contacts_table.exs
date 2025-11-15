defmodule MessagingService.Repo.Migrations.CreateContactsTable do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :email, :string
      add :phone, :integer

      timestamps()
    end

    create constraint(:contacts, :validate_email_or_phone,
             check:
               "(phone IS NOT NULL AND email IS NULL) OR (email IS NOT NULL AND phone IS NULL)"
           )

    alter table(:messages) do
      add :from_id, references(:contacts)
      add :to_id, references(:contacts)
    end
  end
end
