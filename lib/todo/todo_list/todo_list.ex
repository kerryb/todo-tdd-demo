defmodule Todo.TodoList do
  alias Todo.Repo
  alias Todo.TodoList.Item

  def items do
    Repo.all(Item)
  end

  def add_item(text, priority) do
    Repo.insert(%Item{text: text, priority: priority})
  end
end
