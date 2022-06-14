defmodule Todo.TodoListTest do
  use Todo.DataCase, async: true

  alias Todo.TodoList

  describe "Todo.TodoList.items/0" do
    test "returns all the items" do
      insert(:item, text: "Do something")
      insert(:item, text: "Do something else")
      assert [%{text: "Do something"}, %{text: "Do something else"}] = TodoList.items()
    end
  end
end
