defprotocol DBI do

  @type t
  @type statement :: String.t

  @type result :: DBI.Result.t
  @type error

  @type value
  @type bindings :: list({DBI.Statement.placeholder, value})

  @type stream

  @spec query(t, statement) :: {:ok, result} | {:error, error}
  def query(t, statement)
  @spec query(t, statement, bindings) :: {:ok, result} | {:error, error}
  def query(t, statement, bindings)

  @spec query!(t, statement) :: result | no_return
  def query!(t, statement)
  @spec query!(t, statement, bindings) :: result | no_return
  def query!(t, statement, bindings)

  @spec query_stream!(t, statement) :: stream
  def query_stream!(t, statement)
  @spec query_stream!(t, statement, bindings) :: stream
  def query_stream!(t, statement, bindings)

end
