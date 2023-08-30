defmodule LivestateTestbedWeb.PatchChannel do
  use LiveState.Channel, web_module: LivestateTestbedWeb, json_patch: true, max_version: 10

  def init(_channel, _payload, _socket) do
    {:ok, %{result: 0}}
  end

  def handle_event("bump", _param, %{result: result}) do
    {:noreply, %{result: result + 1}}
  end
end
