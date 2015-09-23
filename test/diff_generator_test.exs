defmodule PhoenixDiff.DiffGeneratorTest do
  use ExUnit.Case

  @generated_path Application.get_env(:phoenix_diff, :generated_path)

  test "it can compute the diff between the file contents of two paths" do
    result = PhoenixDiff.DiffGenerator.compare_files(
      @generated_path <> "v1",
      @generated_path <> "v2"
    )

    assert result == {:ok, "diff -Nr -U 1000 test/fixtures/v1/README.md test/fixtures/v2/README.md\n--- test/fixtures/v1/README.md\t2015-09-18 17:31:42.000000000 +0100\n+++ test/fixtures/v2/README.md\t2015-09-18 17:31:42.000000000 +0100\n@@ -1,3 +1,3 @@\n-# V1 README\n+# V2 README\n \n Please read me\ndiff -Nr -U 1000 test/fixtures/v1/src/hello_world.ex test/fixtures/v2/src/hello_world.ex\n--- test/fixtures/v1/src/hello_world.ex\t2015-09-18 17:31:42.000000000 +0100\n+++ test/fixtures/v2/src/hello_world.ex\t2015-09-18 17:31:42.000000000 +0100\n@@ -1 +1 @@\n-IO.puts(\"Hello World\")\n+IO.puts \"Hello World!\"\n"}
  end

  test "it returns an error when both paths are not valid" do
    result = PhoenixDiff.DiffGenerator.compare_files(
      @generated_path <> "v0",
      @generated_path <> "v3"
    )

    assert result == {:error, :enoent}
  end
end
