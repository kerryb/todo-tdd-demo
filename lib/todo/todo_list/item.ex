defmodule Todo.TodoList.Item do
  use Ecto.Schema

  schema "items" do
    timestamps type: :utc_datetime
    field :text, :string
    field :priority, :integer
    field :done?, :boolean, source: :done
  end
end
