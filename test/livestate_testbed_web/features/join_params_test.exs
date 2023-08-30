defmodule LivestateTestbedWeb.Features.JoinParamsTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  import Wallaby.Query

  feature "join params", %{session: session} do
    session
    |> visit("/join_params")
    |> find(css("join-params"))
    |> shadow_root()
    |> assert_has(css("div", text: "foo"))
  end
end
