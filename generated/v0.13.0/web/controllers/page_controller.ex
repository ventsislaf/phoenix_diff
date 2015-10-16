defmodule PhoenixDiff.PageController do
  use PhoenixDiff.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
