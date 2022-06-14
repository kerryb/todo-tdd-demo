defmodule Todo.TodoList do
  alias Todo.Repo
  alias Todo.TodoList.Item

  def items do
    Repo.all(Item)
  end
end
