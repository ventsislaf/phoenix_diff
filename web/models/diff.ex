defmodule PhoenixDiff.FileDiff.Line do
  defstruct type: "", insertion_line_num: 0, deletion_line_num: 0, string: ""

  @insertion "insertion"
  @deletion "deletion"
  @normal ""

  def new("+" <> _full_string = string, previous_line) do
    %PhoenixDiff.FileDiff.Line{
      type: @insertion,
      insertion_line_num: previous_line.insertion_line_num + 1,
      deletion_line_num: previous_line.deletion_line_num,
      string: string
    }
  end

  def new("-" <> _full_string = string, previous_line) do
    %PhoenixDiff.FileDiff.Line{
      type: @deletion,
      insertion_line_num: previous_line.insertion_line_num,
      deletion_line_num: previous_line.deletion_line_num + 1,
      string: string
    }
  end

  def new(string, previous_line) do
    %PhoenixDiff.FileDiff.Line{
      type: @normal,
      insertion_line_num: previous_line.insertion_line_num + 1,
      deletion_line_num: previous_line.deletion_line_num + 1,
      string: string
    }
  end
end

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
