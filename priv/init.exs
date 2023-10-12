manifest = %{wasm: [ %{ path: "priv/wasm/dist/plugin.wasm" } ] }
{:ok, plugin} = Extism.Plugin.new(manifest, true)
{:ok, initial_state} = Extism.Plugin.call(plugin, "init", "")
IO.inspect(initial_state)
