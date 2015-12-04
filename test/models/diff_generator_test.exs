defmodule PhoenixDiff.DiffGeneratorTest do
  use ExUnit.Case

  @generated_path Application.get_env(:phoenix_diff, :generated_path)

  test "it can compute the diff between the file contents of two paths" do
    result = PhoenixDiff.DiffGenerator.compare_files(
      @generated_path <> "v1",
      @generated_path <> "v2"
    )

    assert result == {:ok, [
        %PhoenixDiff.FileDiff{
          meta: "@@ -1,3 +1,3 @@", name: "README.md",
          parsed_lines: [
            %PhoenixDiff.FileDiff.Line{deletion_line_num: 1, insertion_line_num: 0, string: "-# V1 README", type: "line-deletion" },
            %PhoenixDiff.FileDiff.Line{deletion_line_num: 1, insertion_line_num: 1, string: "+# V2 README", type: "line-insertion"},
            %PhoenixDiff.FileDiff.Line{deletion_line_num: 2, insertion_line_num: 2, string: " ", type: ""},
            %PhoenixDiff.FileDiff.Line{deletion_line_num: 3, insertion_line_num: 3, string: " Please read me", type: ""}
          ]
        },
        %PhoenixDiff.FileDiff{
          meta: "@@ -1 +1 @@",
          name: "src/hello_world.ex",
          parsed_lines: [
            %PhoenixDiff.FileDiff.Line{deletion_line_num: 1, insertion_line_num: 0, string: "-IO.puts(\"Hello World\")", type: "line-deletion"},
            %PhoenixDiff.FileDiff.Line{deletion_line_num: 1, insertion_line_num: 1, string: "+IO.puts \"Hello World!\"", type: "line-insertion"}
          ]
        }
      ]
    }
  end

  test "it returns an error when both paths are not valid" do
    result = PhoenixDiff.DiffGenerator.compare_files(
      @generated_path <> "v0",
      @generated_path <> "v3"
    )

    assert result == {:error, :enoent}
  end
end
