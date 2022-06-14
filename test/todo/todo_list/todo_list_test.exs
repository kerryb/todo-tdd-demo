defmodule Todo.TodoListTest do
  use Todo.DataCase, async: true

  alias Todo.TodoList

  describe "Todo.TodoList.items/0" do
    test "returns all the items, sorted by priority then text" do
      insert(:item, text: "Do something", priority: 2)
      insert(:item, text: "And something else", priority: 2)
      insert(:item, text: "Important thing", priority: 1)

      assert [%{text: "Important thing"}, %{text: "And something else"}, %{text: "Do something"}] =
               TodoList.items()
    end
  end

  describe "Todo.TodoList.add_item/2" do
    test "creates an item record with 'done?' set to false" do
      TodoList.add_item("Do something", 2)
      assert [%{text: "Do something", priority: 2, done?: false}] = TodoList.items()
    end
  end

  describe "Todo.TodoList.toggle_done/1" do
    test "marks a not-done item as done" do
      item = insert(:item, text: "Do something", done?: false)
      TodoList.toggle_done(item.id)
      assert Repo.reload(item).done?
    end

    test "marks a done item as not done" do
      item = insert(:item, text: "Do something", done?: true)
      TodoList.toggle_done(item.id)
      refute Repo.reload(item).done?
    end

    test "returns the updated item" do
      item = insert(:item, text: "Do something", done?: true)
      assert {:ok, %{text: "Do something", done?: false}} = TodoList.toggle_done(item.id)
    end
  end

  describe "Todo.TodoList.clear_done/0" do
    test "deletes all done items" do
      insert(:item, text: "Do something", done?: false)
      insert(:item, text: "Done something", done?: true)
      TodoList.clear_done()
      assert [%{text: "Do something"}] = TodoList.items()
    end
  end
end
