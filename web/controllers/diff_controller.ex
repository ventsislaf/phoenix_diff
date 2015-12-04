defmodule PhoenixDiff.DiffController do
  use PhoenixDiff.Web, :controller

  @generated_path Application.get_env(:phoenix_diff, :generated_path)

  def show(conn, %{"source" => source, "target" => target}) do
    {:ok, file_diffs} = PhoenixDiff.DiffGenerator.compare_files(
      @generated_path <> source,
      @generated_path <> target
    )

    render(
      conn,
      "show.html",
      file_diffs: file_diffs,
      source_version: source,
      target_version: target
    )
  end
end
