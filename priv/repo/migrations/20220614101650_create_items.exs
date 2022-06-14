defmodule Todo.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      timestamps()
      add :text, :text, null: false
      add :priority, :integer, null: false
      add :done, :boolean, null: false, default: false
    end
  end
end
