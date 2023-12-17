defmodule LivestateTestbed.People.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:first_name, :last_name, :email])
    |> validate_required([:first_name, :last_name])
  end

  def schematic() do
    Schematic.schema(__MODULE__, %{
      email: Schematic.nullable(Schematic.str()),
      first_name: Schematic.nullable(Schematic.str()),
      last_name: Schematic.nullable(Schematic.str()),
    })
  end

end
