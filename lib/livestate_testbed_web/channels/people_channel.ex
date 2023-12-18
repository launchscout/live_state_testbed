defmodule LivestateTestbedWeb.PeopleChannel do
  use LiveState.Channel, web_module: LivestateTestbedWeb

  alias LivestateTestbed.People
  alias LivestateTestbed.People.Person

  def init(_channel, _payload, _socket) do
    {:ok,
     %{
       people: People.list_people() |> Caramelize.camelize(),
       person: %Person{} |> Caramelize.camelize(),
       editing: false
     }}
  end

  def handle_event("save-person", attrs, %{person: %{"id" => personId} = person})
      when not is_nil(personId) do
    case People.update_person(Snekize.snake(person), Snekize.snake(attrs)) do
      {:ok, person} ->
        {:noreply, %{people: People.list_people() |> Caramelize.camelize(), editing: false}}

      {:error, changeset} ->
        {:noreply, %{errors: []}}
    end
  end

  def handle_event("save-person", person, _state) do
    case People.create_person(Snekize.snake(person)) do
      {:ok, person} ->
        {:noreply, %{people: People.list_people() |> Caramelize.camelize(), editing: false}}

      {:error, changeset} ->
        {:noreply, %{errors: []}}
    end
  end

  def handle_event("add-person", _, state) do
    {:noreply, Map.merge(state, %{editing: true, person: %Person{} |> Caramelize.camelize()})}
  end

  def handle_event("edit-person", %{"personId" => personId}, state) do
    IO.inspect('editing a person')
    person = People.get_person!(personId) |> Caramelize.camelize()
    {:noreply, Map.merge(state, %{editing: true, person: person})}
  end
end
