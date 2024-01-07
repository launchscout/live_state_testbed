defmodule LivestateTestbedWeb.Features.LiveTemplateTest do
  use ExUnit.Case, async: false
  use Wallaby.Feature

  import Wallaby.Query

  # setup do
  #   pid = Ecto.Adapters.SQL.Sandbox.start_owner!(LivestateTestbed.Repo, shared: false)
  #   on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)
  # end

  feature "live template test", %{session: session} do
    session
    |> visit("/live_template")
    # |> assert_has(css("live-template"))
    # |> assert_has(css("live-template button"))
    |> click(css("button"))
    |> find(css("form"))
    |> fill_in(css("input[name='firstName']"), with: "Blob")
    |> fill_in(css("input[name='lastName']"), with: "Dope")
    |> click(css("button", text: "SAVE"))
    |> assert_has(css("td"))
  end
end
