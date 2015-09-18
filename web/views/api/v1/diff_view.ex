defmodule PhoenixDiff.API.V1.DiffView do
  use PhoenixDiff.Web, :view

  def render("index.json", %{diff: diff}) do
    %{diff: diff}
  end
end
