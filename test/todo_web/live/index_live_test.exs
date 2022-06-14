defmodule TodoWeb.IndexLiveTest do
  use TodoWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import Todo.Factory

  @endpoint TodoWeb.Endpoint

  describe "TodoWeb.IndexLive" do
    test "shows existing items", %{conn: conn} do
      item_1 = insert(:item, text: "Do something", priority: 1, done?: false)
      item_2 = insert(:item, text: "Already done", priority: 2, done?: true)

      {:ok, view, _html} = live(conn, "/")

      assert view |> element("#item-#{item_1.id} label", "Do something") |> has_element?()
      assert view |> element("#item-#{item_1.id} input:not([:checked])") |> has_element?()

      assert view |> element("#item-#{item_2.id} label", "Already done") |> has_element?()
      assert view |> element("#item-#{item_2.id} input[checked]") |> has_element?()
    end
  end
end
