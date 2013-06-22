Code.require_file "test_helper.exs", __DIR__

defmodule DBITest do
  use ExUnit.Case

  test "parse statement with placeholders" do
    assert DBI.Statement.parse("SELECT x FROM y WHERE a = :{a} AND b = :{b} AND c = :{a} AND d = :{A}") ==
      ["SELECT x FROM y WHERE a = ", :a ," AND b = ", :b, " AND c = ", :a, " AND d = ", :A]
  end
end
