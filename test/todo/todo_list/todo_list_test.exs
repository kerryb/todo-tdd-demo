defmodule Todo.TodoListTest do
  use Todo.DataCase, async: true

  alias Todo.TodoList
  alias Todo.TodoList.Item

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

  describe "Todo.TodoList.random_top_priority_item/0" do
    test "returns a dummy struct when there are no items" do
      assert TodoList.random_top_priority_item() == %Item{text: "There’s nothing to do!"}
    end

    test "returns the highest priority non-done item when there's only one" do
      insert(:item, text: "Do something", done?: false, priority: 2)
      insert(:item, text: "Done something", done?: true, priority: 1)
      insert(:item, text: "Less important", done?: false, priority: 3)
      assert %{text: "Do something"} = TodoList.random_top_priority_item()
    end

    test "returns a random highest priority non-done item when there's more than one" do
      insert(:item, text: "Do something", done?: false, priority: 2)
      insert(:item, text: "Do something else", done?: false, priority: 2)
      insert(:item, text: "Done something", done?: true, priority: 1)
      insert(:item, text: "Less important", done?: false, priority: 3)
      assert %{text: "Do something else"} = TodoList.random_top_priority_item(&List.last/1)
    end
  end
end
