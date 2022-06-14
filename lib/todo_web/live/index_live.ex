defmodule TodoWeb.IndexLive do
  use TodoWeb, :live_view

  alias Todo.TodoList

  def mount(_params, _session, socket) do
    {:ok, assign(socket, items: TodoList.items())}
  end
end
