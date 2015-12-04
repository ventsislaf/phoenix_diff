defmodule PhoenixDiff.FileDiff.Line do
  defstruct type: "", insertion_line_num: 0, deletion_line_num: 0, string: ""

  @insertion "line-insertion"
  @deletion "line-deletion"
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
