defmodule PhoenixDiff.DiffGenerator do
  def compare_files(source, target) do
    System.cmd("diff", ["-Nr", "-U", "1000", "-x", ".DS_Store", source, target])
    |> format_response
  end

  defp format_response({raw_diff, 1}) do
    {:ok, raw_diff}
  end

  defp format_response(_) do
    {:error, :enoent}
  end
end
