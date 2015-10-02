defmodule PhoenixDiff.DiffController do
  use PhoenixDiff.Web, :controller

  def show(conn, _params) do
    render(conn, "show.html", something: "foo")
  end
end
