defmodule OnionWeb.PageController do
  use OnionWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
