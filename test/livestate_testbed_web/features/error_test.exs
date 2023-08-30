defmodule LivestateTestbedWeb.Features.ErrorTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  import Wallaby.Query

  feature "join params", %{session: session} do
    session
    |> visit("/errors")
    |> find(css("connect-error"))
    |> shadow_root()
    |> assert_has(css("div", text: "error"))
  end
end
