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

  def handle_event("input", person, state) do
    :timer.sleep(300)
    {:noreply, state}
  end

  def handle_event("save-person", attrs, %{person: %{"id" => person_id}} = state)
      when not is_nil(person_id) do
    with person <- People.get_person!(person_id),
         {:ok, saved_person} <- People.update_person(person, Snekize.snake(attrs)) do
      {:noreply,
       %{
         people: People.list_people() |> Caramelize.camelize(),
         person: Caramelize.camelize(saved_person),
         editing: false
       }}
    else
      {:error, changeset} ->
        {:noreply, Map.put(state, :errors, format_errors(changeset))}
    end
  end

  def handle_event("save-person", person, state) do
    case People.create_person(Snekize.snake(person)) do
      {:ok, saved_person} ->
        {:noreply,
         %{
           people: People.list_people() |> Caramelize.camelize(),
           person: Caramelize.camelize(saved_person),
           editing: false
         }}

      {:error, changeset} ->
        {:noreply, Map.put(state, :errors, format_errors(changeset))}
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

  defp format_errors(changeset) do
    changeset.errors |> Enum.map(fn {field, [error | _]} -> {field, error} end)
  end
end
