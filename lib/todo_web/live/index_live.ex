defmodule TodoWeb.IndexLive do
  use TodoWeb, :live_view

  alias Phoenix.LiveView
  alias Todo.TodoList
  alias Todo.TodoList.Item

  @impl LiveView
  def mount(_params, _session, socket) do
    {:ok, assign(socket, items: TodoList.items(), new_item: Item.changeset(%Item{priority: 3}))}
  end

  @impl LiveView
  def handle_event("toggle-done", %{"id" => id}, socket) do
    TodoList.toggle_done(id)
    {:noreply, assign(socket, items: TodoList.items())}
  end

  def handle_event("add-item", %{"item" => params}, socket) do
    {:ok, _item} = TodoList.add_item(params["text"], String.to_integer(params["priority"]))
    {:noreply, assign(socket, items: TodoList.items())}
  end
end
