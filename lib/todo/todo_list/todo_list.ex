defmodule Todo.TodoList do
  import Ecto.Query

  alias Ecto.Changeset
  alias Todo.Repo
  alias Todo.TodoList.Item

  def items do
    Repo.all(from Item, order_by: [:priority, :text])
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

  def random_top_priority_item(picker \\ &Enum.random/1) do
    case Repo.all(from i in Item, where: not i.done?) do
      [] -> %Item{text: "There’s nothing to do!"}
      items -> pick_item(items, picker)
    end
  end

  defp pick_item(items, picker) do
    highest_priority = Enum.min_by(items, & &1.priority).priority
    items |> Enum.filter(&(&1.priority == highest_priority)) |> picker.()
  end
end
