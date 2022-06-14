defmodule TodoWeb.IndexLiveTest do
  use TodoWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import Todo.Factory

  alias Todo.TodoList

  @endpoint TodoWeb.Endpoint

  describe "TodoWeb.IndexLive" do
    test "shows existing items", %{conn: conn} do
      item_1 = insert(:item, text: "Do something", priority: 1, done?: false)
      item_2 = insert(:item, text: "Already done", priority: 2, done?: true)

      {:ok, view, _html} = live(conn, "/")

      assert view |> element("#item-#{item_1.id} label", "Do something (P1)") |> has_element?()
      assert view |> element("#item-#{item_1.id} input:not([:checked])") |> has_element?()

      assert view |> element("#item-#{item_2.id} label", "Already done (P2)") |> has_element?()
      assert view |> element("#item-#{item_2.id} input[checked]") |> has_element?()
    end

    test "allows items to be added", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      view
      |> element("#add-item")
      |> render_submit(%{"item" => %{"text" => "A new item", "priority" => "2"}})

      [item] = TodoList.items()
      assert view |> element("#item-#{item.id} label", "A new item (P2)") |> has_element?()
      assert view |> element("#item-#{item.id} input:not([:checked])") |> has_element?()
    end

    test "disables the 'add' button until text is provided", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      assert view |> element("button[type=submit][disabled]") |> has_element?()

      view
      |> element("#add-item")
      |> render_change(%{"item" => %{"text" => "A new item", "priority" => "2"}})

      assert view |> element("button[type=submit]:not([disabled])") |> has_element?()
    end

    test "allows items to be marked as done", %{conn: conn} do
      item = insert(:item, text: "Do something", priority: 1, done?: false)

      {:ok, view, _html} = live(conn, "/")
      view |> element("#item-#{item.id} input") |> render_click()

      assert view |> element("#item-#{item.id} input[checked]") |> has_element?()
      assert [%{done?: true}] = TodoList.items()
    end

    test "allows items to be marked as not done", %{conn: conn} do
      item = insert(:item, text: "Do something", priority: 1, done?: true)

      {:ok, view, _html} = live(conn, "/")
      view |> element("#item-#{item.id} input") |> render_click()

      assert view |> element("#item-#{item.id} input:not([checked])") |> has_element?()
      assert [%{done?: false}] = TodoList.items()
    end

    test "allows done items to be cleared", %{conn: conn} do
      insert(:item, text: "Do something", priority: 1, done?: false)
      insert(:item, text: "Done something", priority: 1, done?: true)

      {:ok, view, _html} = live(conn, "/")
      view |> element("input[value='Clear done']") |> render_click()

      assert view |> element("label", "Do something") |> has_element?()
      refute view |> element("label", "Done something") |> has_element?()
    end

    test "disables the 'clear done' button if there are no elements", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      assert view |> element("input[value='Clear done'][disabled]") |> has_element?()
    end
  end
end
