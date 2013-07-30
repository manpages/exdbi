Code.require_file "test_helper.exs", __DIR__

defmodule DBI.ResultTest do
  use ExUnit.Case

  test "result column index" do
    assert DBI.Result.new(columns: ["col1", "col2", "col3"]).index("col2") == 1
  end

  test "zip the entire result" do
    result = DBI.Result.new(columns: ["col1", "col2", "col3"],
                            rows: [{"r1", "r1", "r1"},
                                   {"r2", "r2", "r2"},
                                   {"r3", "r3", "r3"},
                                  ])
    assert result.zip == [[{"col1", "r1"}, {"col2", "r1"}, {"col3", "r1"}],
                          [{"col1", "r2"}, {"col2", "r2"}, {"col3", "r2"}],
                          [{"col1", "r3"}, {"col2", "r3"}, {"col3", "r3"}],
    ]
  end

  test "zip a row" do
    result = DBI.Result.new(columns: ["col1", "col2", "col3"])
    assert result.zip({"r1", "r1", "r1"}) == [{"col1", "r1"}, {"col2", "r1"}, {"col3", "r1"}]
  end

  test "result should be an enumerable" do
    rows = [{"r1", "r1", "r1"},
            {"r2", "r2", "r2"},
            {"r3", "r3", "r3"},
    ]
    result = DBI.Result.new(columns: ["col1", "col2", "col3"],
                            rows: rows)
    assert Enum.to_list(result) == rows
  end

  test "getting keywordlist" do
    result = DBI.Result.new()
    assert result.keywords == []

    result = DBI.Result.new(columns: ["col1", "col2", "col3"],
                            rows: [{"r1", "r1", "r1"},
                                   {"r2", "r2", "r2"},
                                   {"r3", "r3", "r3"},
                                  ])
    assert result.keywords == [ [col1: "r1", col2: "r1", col3: "r1"], 
                                [col1: "r2", col2: "r2", col3: "r2"], 
                                [col1: "r3", col2: "r3", col3: "r3"] ]
  end

end
