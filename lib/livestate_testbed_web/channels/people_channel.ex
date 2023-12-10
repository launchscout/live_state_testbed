defmodule LivestateTestbedWeb.PeopleChannel do
  use LiveState.Channel, web_module: LivestateTestbedWeb

  def init(_channel, _payload, _socket) do
    {:ok, %{people: [%{"firstName" => "John", "lastName" => "Doe", "age" => 42}], newPerson: %{firstName: "", lastName: ""}}}
  end

  def handle_event("create-person", person, %{people: people}) do
    {:noreply, %{people: people ++ [person], newPerson: %{firstName: "", lastName: "", age: ""}, adding: false}}
  end

  def handle_event("add-person", _, state) do
    {:noreply, Map.put(state, :adding, true)}
  end
end
