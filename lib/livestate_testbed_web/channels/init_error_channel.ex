defmodule LivestateTestbedWeb.InitErrorChannel do
  use LiveState.Channel, web_module: LivestateTestbedWeb

  def init(_channel, _params, _socket) do
    {:error, "You suck"}
  end

end
