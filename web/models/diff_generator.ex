defmodule PhoenixDiff.DiffGenerator do
  def compare_files(source, target) do
    System.cmd("diff", ["-Nr", "-U", "1000", "-x", ".DS_Store", source, target])
    |> format_result
    |> parse_result
  end

  defp parse_result({:ok, diff}) do
    file_diffs = diff
    |> String.split("diff -Nr -U")
    |> tl
    |> Enum.map(&PhoenixDiff.FileDiff.build/1)

    {:ok, file_diffs}
  end

  defp parse_result(error) do
    error
  end

  defp format_result({raw_diff, 1}) do
    {:ok, raw_diff}
  end

  defp format_result(_) do
    {:error, :enoent}
  end
end
