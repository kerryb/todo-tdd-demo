defmodule Todo.TodoList do
  import Ecto.Query

  alias Ecto.Changeset
  alias Todo.Repo
  alias Todo.TodoList.Item

  def items do
    Repo.all(Item)
  end

  def add_item(text, priority) do
    Repo.insert(%Item{text: text, priority: priority})
  end

  def toggle_done(item_id) do
    Item |> Repo.get(item_id) |> toggle_done_field() |> Repo.update()
  end

  defp toggle_done_field(item) do
    Changeset.change(item, done?: not item.done?)
  end

  def clear_done do
    Repo.delete_all(from i in Item, where: i.done?)
  end
end
