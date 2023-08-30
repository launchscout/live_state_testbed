defmodule LivestateTestbedWeb.Features.PatchChannelTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  import Wallaby.Query

  feature "version rollover", %{session: session} do
    session = session
    |> visit("/patchy")
    |> find(css("patch-thing"))
    |> shadow_root()

    session = Enum.reduce(0..15, session, fn i, session ->
      session |> click(css("button"))
      session
    end)
    session |> assert_has(css("div", text: "16"))
    session |> assert_has(css("div", text: "5"))
  end

end
