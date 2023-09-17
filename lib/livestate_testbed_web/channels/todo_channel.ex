defmodule LivestateTestbedWeb.TodoChannel do
  use LiveState.Channel, web_module: LivestateTestbedWeb

  def init(_channel, _payload, _socket) do
    {:ok, %{todos: []}}
  end

  def handle_event("add_todo", %{"todo" => todo}, %{todos: todos}) do
    :timer.sleep(500)
    IO.inspect("adding todo #{todo}")
    {:noreply, %{todos: todos ++ [todo]}}
  end
end
