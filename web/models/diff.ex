defmodule PhoenixDiff.FileDiff do
  defstruct name: nil, meta: nil, lines: []

  def build(string) do
    diffs =
      string
      |> String.split("\n")

    [name, _, _, meta | lines] = diffs
    %PhoenixDiff.FileDiff{name: name, meta: meta, lines: lines}
  end
end
