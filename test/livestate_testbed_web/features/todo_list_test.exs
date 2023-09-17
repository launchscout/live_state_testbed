defmodule LivestateTestbedWeb.Features.TodoListTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  import Wallaby.Query

  feature "todo list", %{session: session} do
    session
    |> visit("/")
    |> assert_text("todo list")
    |> find(css("todo-form"))
    |> shadow_root()
    |> fill_in(css("input[name='todo']"), with: "Do a thing")
    |> click(css("button"))
    |> assert_has(css("button[disabled]"))

    session
    |> find(css("todo-list"))
    |> shadow_root()
    |> assert_has(css("li", text: "Do a thing"))
  end

  @tag :skip
  feature "react todo list", %{session: session} do
    session
    |> visit("/react")
    |> fill_in(css("input[name='todo']"), with: "Do a thing")
    |> click(css("button"))
    |> assert_has(css("li", text: "Do a thing"))
  end
end
