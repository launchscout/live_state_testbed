defmodule LivestateTestbedWeb.Features.ErrorTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  import Wallaby.Query

  feature "connect error", %{session: session} do
    session
    |> visit("/errors")
    |> find(css("display-error#connect"))
    |> shadow_root()
    |> assert_has(css("div", text: "unmatched topic"))
  end

  feature "init error", %{session: session} do
    session
    |> visit("/errors")
    |> find(css("display-error#init"))
    |> shadow_root()
    |> assert_has(css("div", text: "You suck"))
  end
end
