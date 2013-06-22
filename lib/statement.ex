defmodule DBI.Statement do

  @type placeholder :: atom

  @spec parse(DBI.Statement) :: list(DBI.statement | placeholder)

  def parse(statement), do: Enum.reverse(parse(statement, "", []))

  defp parse(":{" <> rest, bacc, acc) do
    {placeholder, rest} = parse_placeholder(rest, "")
    parse(rest, "", [placeholder, bacc|acc])
  end
  defp parse(<< a :: [binary, 1], rest :: binary >>, bacc, acc) do
    parse(rest, bacc <> a, acc)
  end
  defp parse(<<>>, "", acc) do
    acc
  end
  defp parse(<<>>, bacc, acc) do
    [bacc|acc]
  end

  defp parse_placeholder("}" <> rest, acc) do
    {:"#{acc}", rest}
  end
  defp parse_placeholder(<< a :: [binary, 1], rest :: binary >>, acc) do
    parse_placeholder(rest, acc <> a)
  end
  defp parse_placeholder(<<>>, acc) do
    raise ArgumentError, message: "bad placeholder #{acc}"
  end
end