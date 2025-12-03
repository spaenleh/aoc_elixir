defmodule AocElixir.Solutions.Y25.Day03 do
  alias AoC.Input

  def unique_pairs(list) do
    list
    |> Enum.with_index()
    |> Enum.flat_map(fn {x, i} ->
      list
      |> Enum.drop(i + 1)
      |> Enum.map(fn y ->
        # IO.inspect({x, y})
        String.to_integer("#{x}#{y}")
      end)
    end)
  end

  def parse(input, _part) do
    Input.stream!(input, trim: true)
    |> Enum.map(fn line -> line |> String.to_integer() |> Integer.digits() end)
  end

  def part_one(problem) do
    problem
    |> Enum.map(&unique_pairs/1)
    # |> IO.inspect()
    |> Enum.map(&Enum.max(&1))
    # |> IO.inspect()
    |> Enum.sum()
  end

  # def part_two(problem) do
  #   problem
  # end
end
