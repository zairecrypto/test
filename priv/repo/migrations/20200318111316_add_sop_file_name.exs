defmodule MyTests.Repo.Migrations.AddSopFileName do
  use Ecto.Migration

  def change do
    create table(:sops) do
      add :file_title, :string

      timestamps()
    end
  end
end
