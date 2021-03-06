defmodule PhoenixDiff.API.V1.DiffController do
  use PhoenixDiff.Web, :controller

  @generated_path Application.get_env(:phoenix_diff, :generated_path)

  def index(conn, %{"source" => source, "target" => target}) do
    {:ok, diff} = PhoenixDiff.DiffGenerator.compare_files(
      @generated_path <> source,
      @generated_path <> target
    )

    render(conn, "index.json", diff: diff)
  end
end
