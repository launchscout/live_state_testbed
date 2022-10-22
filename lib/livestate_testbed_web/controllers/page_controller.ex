defmodule LivestateTestbedWeb.PageController do
  use LivestateTestbedWeb, :controller
  alias LivestateTestbedWeb.Endpoint

  def index(conn, _params) do
    url = "#{String.replace(Endpoint.url(), "http:", "ws:")}/socket"
    conn
    |> assign(:url, url)
    |> render("index.html")
  end
end
