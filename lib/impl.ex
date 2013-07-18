defmodule DBI.Implementation do

  defmacro __using__(_opts) do
    quote do
      def query(t, statement) do
        query(t, statement, [])
      end

      def query!(t, statement) do
        query!(t, statement, [])
      end

      def query!(t, statement, bindings) do
        case query(t, statement, bindings) do
           list when is_list(list) ->
             lc item inlist list do
               case item do
                 {:ok, result} -> result
                 {:error, error} -> raise error
               end
             end
           {:ok, result} -> result
           {:error, error} -> raise error
        end
      end

      def query_stream!(t, statement, bindings // []) do
        stream(t, statement, bindings, &1, &2)
      end

      defp stream(t, statement, bindings, acc, fun) do
        result = query!(t, statement, bindings)
        stream(acc, fun, result)
      end

      defp stream(acc, _fun, DBI.Result[rows: []]) do
        acc
      end

      defp stream(acc, fun, DBI.Result[rows: [h|t]] = result) do
         fun.(h, acc) |> stream(fun, result.rows(t))
      end

      Record.import DBI.Result, as: :result

    end
  end

end