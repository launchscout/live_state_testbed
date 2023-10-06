defmodule LivestateTestbedWeb.JsWasmChannel do
  use LiveState.Channel, web_module: LivestateTestbedWeb

  def init(_channel, _payload, socket) do
    manifest = %{wasm: [ %{ path: "priv/wasm/dist/plugin.wasm" } ] }
    {:ok, plugin} = Extism.Plugin.new(manifest, true)
    {:ok, initial_state} = Extism.Plugin.call(plugin, "init", "")
    {:ok, Jason.decode!(initial_state), socket |> assign(:plugin, plugin)}
  end

  def handle_event(event, payload, state, %{assigns: %{plugin: plugin}} = socket) do
    {:ok, new_state} = Extism.Plugin.call(plugin, event, Jason.encode!([payload, state]))
    {:noreply, Jason.decode!(new_state), socket}
  end
end
