defmodule Todo.TodoList.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    timestamps type: :utc_datetime
    field :text, :string
    field :priority, :integer
    field :done?, :boolean, source: :done
  end

  def changeset(item, changes \\ %{}) do
    item
    |> cast(changes, [:text, :priority, :done?])
    |> validate_required(:text)
    |> validate_number(:priority, greater_than_or_equal_to: 1, less_than_or_equal_to: 3)
  end
end
