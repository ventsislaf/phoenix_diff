defmodule PhoenixDiff.API.V1.DiffController do
  use PhoenixDiff.Web, :controller

  def index(conn, %{"source" => source, "target" => target}) do
    {:ok, diff} = PhoenixDiff.DiffGenerator.compare_files(
      Application.get_env(:phoenix_diff, :generated_path) <> source,
      Application.get_env(:phoenix_diff, :generated_path) <> target
    )

    render(conn, "index.json", diff: diff)
  end
end
