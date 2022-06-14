defmodule TodoWeb.IndexLive do
  use TodoWeb, :live_view

  alias Phoenix.LiveView
  alias Todo.TodoList

  @impl LiveView
  def mount(_params, _session, socket) do
    {:ok, assign(socket, items: TodoList.items())}
  end

  @impl LiveView
  def handle_event("toggle-done", %{"id" => id}, socket) do
    TodoList.toggle_done(id)
    {:noreply, assign(socket, items: TodoList.items())}
  end
end
