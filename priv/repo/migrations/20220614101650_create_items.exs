defmodule Todo.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      timestamps()
      add :text, :text
      add :priority, :integer
      add :done, :boolean
    end
  end
end
