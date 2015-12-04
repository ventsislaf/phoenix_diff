defmodule PhoenixDiff.PageControllerTest do
  use PhoenixDiff.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "PhoenixDiff"
  end
end
