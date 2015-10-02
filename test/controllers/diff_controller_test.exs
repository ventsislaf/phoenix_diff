defmodule PhoenixDiff.DiffControllerTest do
  use PhoenixDiff.ConnCase

  test "GET /diff" do
    conn = get(conn, "/diff", %{source: "v1", target: "v2"})

    assert html_response(conn, 200) =~ "foo"
  end
end
