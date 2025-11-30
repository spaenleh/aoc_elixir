defmodule AocElixir.Parsing do
  @doc """
  Parse numbers in the line by splitting on whitespace 
  """
  def numbers_on_line(string) do
    string
    |> String.split()
    |> Enum.map(fn str ->
      {nbr, _} = Integer.parse(str)
      nbr
    end)
  end
end
