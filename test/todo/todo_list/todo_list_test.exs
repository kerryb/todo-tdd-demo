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

  describe "Todo.TodoList.add_item/2" do
    test "creates an item record with 'done?' set to false" do
      TodoList.add_item("Do something", 2)
      assert [%{text: "Do something", priority: 2, done?: false}] = TodoList.items()
    end
  end

  describe "Todo.TodoList.mark_done/1" do
    test "marks the specified item as done" do
      item = insert(:item, text: "Do something", done?: false)
      TodoList.mark_done(item.id)
      assert Repo.reload(item).done?
    end
  end
end
