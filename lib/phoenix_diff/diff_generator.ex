defmodule PhoenixDiff.DiffGenerator do
  def compare_files(source, target) do
    format_response System.cmd("diff", ["-Nr", "-U", "1000", source, target])
  end

  defp format_response({raw_diff, 1}) do
    {:ok, raw_diff}
  end

  defp format_response(_) do
    {:error, :enoent}
  end
end
