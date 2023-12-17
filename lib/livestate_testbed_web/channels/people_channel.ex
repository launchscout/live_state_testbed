defmodule LivestateTestbedWeb.PeopleChannel do
  use LiveState.Channel, web_module: LivestateTestbedWeb

  alias LivestateTestbed.People
  alias LivestateTestbed.People.Person

  def init(_channel, _payload, _socket) do
    {:ok, %{people: People.list_people() |> Caramelize.camelize(), person: %Person{} |> Caramelize.camelize(), adding: false}}
  end

  def handle_event("create-person", person, _state) do
    case People.create_person(Snekize.snake(person)) do
      {:ok, person} ->
        {:noreply, %{people: People.list_people() |> Caramelize.camelize(), person: %Person{} |> Caramelize.camelize(), adding: false}}
      {:error, changeset} ->
        {:noreply, %{errors: []}}
    end
  end

  def handle_event("add-person", _, state) do
    {:noreply, Map.put(state, :adding, true)}
  end

end
