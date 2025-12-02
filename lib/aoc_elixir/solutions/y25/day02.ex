defmodule AocElixir.Solutions.Y25.Day02 do
  alias AoC.Input

  def parse_ranges(range) do
    [ls, rs] = String.split(range, "-")
    String.to_integer(ls)..String.to_integer(rs)
  end

  def parse(input, _part) do
    Input.read!(input)
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&parse_ranges/1)
  end

  def part_one(problem) do
    problem
    # compute in parallel each range
    |> Task.async_stream(fn seq ->
      # inside the range, remove ids that are invalid
      Enum.filter(seq, &invalid?/1)
    end)
    # get the results, we need to extract the value from the result
    |> Enum.flat_map(fn {:ok, inv} -> inv end)
    # sum all invalid ids
    |> Enum.sum()
  end

  # def part_two(problem) do
  #   problem
  # end
  #

  @doc """
  Checks of the given identifier is considered invalid.

  An identifier is invalid when it can be represented by `blockblock` i.e. twice repeated sequence of numbers
  """
  def invalid?(id) do
    id_string = Integer.to_string(id)
    id_length = String.length(id_string)

    if Bitwise.band(id_length, 1) == 1 do
      false
    else
      {s1, s2} = String.split_at(id_string, div(id_length, 2))
      s1 == s2
    end
  end
end
