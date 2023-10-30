defmodule LivestateTestbedWeb.WasmComponent do
  use Rustler, otp_app: :livestate_testbed, crate: "livestatetestbedweb_wasmcomponent"

  # When your NIF is loaded, it will override this function.
  def other_init(), do: :erlang.nif_error(:nif_not_loaded)
end
