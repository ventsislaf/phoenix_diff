defmodule PhoenixDiff.DiffGenerator do
  def compare_files(source, target) do
    {:ok, diff} =
      System.cmd("diff", ["-Nr", "-U", "1000", "-x", ".DS_Store", source, target])
      |> format_response

    diff
    |> String.split("diff -Nr -U")
    |> tl
    |> Enum.map(&PhoenixDiff.FileDiff.build/1)
  end

  defp format_response({raw_diff, 1}) do
    {:ok, raw_diff}
  end

  defp format_response(_) do
    {:error, :enoent}
  end
end
