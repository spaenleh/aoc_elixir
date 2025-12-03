defmodule AocElixir.Solutions.Y25.Day03 do
  alias AoC.Input

  def parse(input, _part) do
    Input.stream!(input, trim: true)
    |> Stream.map(fn line -> line |> String.to_integer() |> Integer.digits() end)
  end

  def part_one(problem) do
    problem
    |> Enum.map(&find_joltage(&1, 2))
    |> Enum.sum()
  end

  def part_two(problem) do
    problem
    |> Enum.map(&find_joltage(&1, 12))
    |> Enum.sum()
  end

  def find_joltage(batteries, size) do
    1..size
    |> Enum.reduce({0, []}, fn term_index, {start_index, joltage_digits} ->
      # create the range of digits we will explore
      # reduce the start from the index that was found last, only look after that one
      # the end of the range is: from the end, only the remaining digits we want to find -1
      range =
        start_index..(length(batteries) - size + term_index - 1)//1

      {digit, index} =
        Enum.max_by(
          Enum.with_index(Enum.slice(batteries, range)),
          fn {val, _idx} ->
            val
          end
        )

      # the final index is relative to the truncated range we used, so we need to add the start_index
      {start_index + index + 1, [digit | joltage_digits]}
    end)
    # the result is a 2-tuple with {last_index, joltage_digits}, we take only the digits
    |> elem(1)
    # digits are reversed because of how adding to lists in elixir works
    |> Enum.reverse()
    # convert joltage from a list of digits to an integer -- equivalent to joining the String representation
    |> Integer.undigits()
  end

  @doc """
  Brute-force approach for part one.
  Uses a ordered pair approach, takes 200ms on part one

  This is not scalable to longer joltage strings (12 in part 2)
  """
  def part_one_brute(problem) do
    problem
    |> Enum.map(&unique_pairs/1)
    |> Enum.map(&Enum.max(&1))
    |> Enum.sum()
  end

  @doc """
  Create all ordered paires from the list.
  """
  def unique_pairs(list) do
    list
    |> Enum.with_index()
    |> Enum.flat_map(fn {x, i} ->
      list
      |> Enum.drop(i + 1)
      |> Enum.map(fn y ->
        Integer.undigits([x, y])
      end)
    end)
  end
end
