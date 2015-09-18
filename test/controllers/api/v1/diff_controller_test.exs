defmodule PhoenixDiff.API.V1.DiffControllerTest do
  use PhoenixDiff.ConnCase

  setup do
    conn =
      conn()
      |> put_req_header("accept", "application/json")

    {:ok, conn: conn}
  end

  test "GET /api/v1/diff", %{conn: conn} do
    conn = get(conn, "/api/v1/diff", %{source: "v1.0.1", target: "v1.0.2"})

    response = json_response(conn, 200)

    assert is_binary(response["diff"])
  end
end
