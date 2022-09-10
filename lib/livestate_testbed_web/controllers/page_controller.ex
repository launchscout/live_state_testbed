defmodule LivestateTestbedWeb.PageController do
  use LivestateTestbedWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
