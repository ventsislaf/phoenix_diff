defmodule PhoenixDiff.API.V1.DiffController do
  use PhoenixDiff.Web, :controller

  @generated_path "generated/"

  def index(conn, %{"source" => source, "target" => target}) do
    {:ok, diff} = PhoenixDiff.DiffGenerator.compare_files(
      @generated_path <> source,
      @generated_path <> target
    )

    render(conn, "index.json", diff: diff)
  end
end
