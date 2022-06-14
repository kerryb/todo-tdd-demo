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

  def random_high_priority_item do
    case Repo.all(from i in Item, where: not i.done?) do
      [] ->
        nil

      items ->
        highest_priority = Enum.min_by(items, & &1.priority).priority
        Enum.find(items, &(&1.priority == highest_priority))
    end
  end
end
