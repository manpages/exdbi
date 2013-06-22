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
           {:ok, result} -> result
           {:error, error} -> raise error
        end
      end

     Record.import DBI.Result, as: :result

    end
  end

end