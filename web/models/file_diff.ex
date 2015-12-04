defmodule PhoenixDiff.FileDiff do
  defstruct name: nil, meta: nil, parsed_lines: []

  def build(string) do
    diffs =
      string
      |> String.split("\n")

    [first_line, _, _, meta | lines] = diffs
    [_match, name] = Regex.run(~r/generated\/[^\/]+\/([^\s]+)\z/, first_line)

    if (String.ends_with?(string, "\n")) do
      lines = List.delete_at(lines, -1)
    end

    {parsed_lines, _last_parsed_line} = lines
      |> Enum.map_reduce(%PhoenixDiff.FileDiff.Line{}, fn(line, acc) ->
        parsed_line = PhoenixDiff.FileDiff.Line.new(line, acc)

        {parsed_line, parsed_line}
      end)

    %PhoenixDiff.FileDiff{name: name, meta: meta, parsed_lines: parsed_lines}
  end
end
