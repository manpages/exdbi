defrecord DBI.Result, count: nil, columns: [], rows: [] do

  def zip(row, __MODULE__[columns: columns]) when is_tuple(row) and
                                             tuple_size(row) == length(columns) do
    Enum.zip(columns, tuple_to_list(row))
  end

  def zip(__MODULE__[columns: columns, rows: rows]) do
    lc row inlist rows, do: Enum.zip(columns, tuple_to_list(row))
  end

  def index(column, __MODULE__[columns: columns]) do
    Enum.find_index(columns, &1 == column)
  end

  def keywords(result = __MODULE__[]) do
    Enum.map(result, fn(row) ->
      result.zip(row) |>
      Enum.map(fn({key, value}) ->
        {binary_to_atom(key), value}
      end)
    end)
  end
end

defimpl Enumerable, for: DBI.Result do

  alias DBI.Result, as: T

  def count(T[rows: rows]), do: length(rows)
  def member?(T[rows: rows], row), do: Enum.member?(rows, row)

  def reduce(T[rows: [h|t]] = result, acc, fun) do
    reduce(result.rows(t), fun.(h, acc), fun)
  end
  def reduce(T[rows: []], acc, _fun), do: acc
end
