defmodule PhoenixDiff.DiffGeneratorTest do
  use ExUnit.Case

  test "it can compute the diff between the file contents of two paths" do
    result = PhoenixDiff.DiffGenerator.compare_files(
      "test/support/fixtures/v1",
      "test/support/fixtures/v2"
    )

    assert result == {:ok, "diff -Nr -U 1000 test/support/fixtures/v1/README.md test/support/fixtures/v2/README.md\n--- test/support/fixtures/v1/README.md\t2015-09-18 17:31:42.000000000 +0100\n+++ test/support/fixtures/v2/README.md\t2015-09-18 17:31:42.000000000 +0100\n@@ -1,3 +1,3 @@\n-# V1 README\n+# V2 README\n \n Please read me\ndiff -Nr -U 1000 test/support/fixtures/v1/src/hello_world.ex test/support/fixtures/v2/src/hello_world.ex\n--- test/support/fixtures/v1/src/hello_world.ex\t2015-09-18 17:31:42.000000000 +0100\n+++ test/support/fixtures/v2/src/hello_world.ex\t2015-09-18 17:31:42.000000000 +0100\n@@ -1 +1 @@\n-IO.puts(\"Hello World\")\n+IO.puts \"Hello World!\"\n"}
  end

  test "it returns an error when both paths are not valid" do
    result = PhoenixDiff.DiffGenerator.compare_files(
      "test/support/fixtures/v0",
      "test/support/fixtures/v3"
    )

    assert result == {:error, :enoent}
  end
end
