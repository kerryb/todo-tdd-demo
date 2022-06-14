defmodule Todo.TodoList.ItemTest do
  use Todo.DataCase, async: true

  alias Todo.TodoList.Item

  describe "Todo.TodoList.Item.changeset/2" do
    test "accepts valid parameters" do
      changeset = Item.changeset(%Item{}, %{text: "An item", priority: 1, done?: true})
      assert [] = changeset.errors
    end

    test "validates presence of text" do
      changeset = Item.changeset(%Item{})
      assert Keyword.has_key?(changeset.errors, :text)
    end

    test "validates that priority is a number between 1 and 3" do
      for priority <- [0, 4] do
        changeset = Item.changeset(%Item{}, %{priority: priority})
        assert Keyword.has_key?(changeset.errors, :priority)
      end

      for priority <- 1..3 do
        changeset = Item.changeset(%Item{}, %{priority: priority})
        refute Keyword.has_key?(changeset.errors, :priority)
      end
    end
  end
end
