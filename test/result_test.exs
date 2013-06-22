Code.require_file "test_helper.exs", __DIR__

defmodule DBI.ResultTest do
  use ExUnit.Case

  test "result column index" do
    assert DBI.Result.new(columns: ["col1", "col2", "col3"]).index("col2") == 1
  end
end
