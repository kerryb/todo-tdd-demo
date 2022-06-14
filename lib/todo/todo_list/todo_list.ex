defmodule Todo.TodoList do
  import Ecto.Query

  alias Todo.Repo
  alias Todo.TodoList.Item

  def items do
    Repo.all(Item)
  end

  def add_item(text, priority) do
    Repo.insert(%Item{text: text, priority: priority})
  end

  def mark_done(item_id) do
    Repo.update_all(from(i in Item, where: i.id == ^item_id), set: [done?: true])
  end
end
