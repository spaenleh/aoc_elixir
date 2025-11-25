defmodule AocElixir.Solutions.Y20.Day01 do
  alias AoC.Input

  def parse(input, _part) do
    input
    |> Input.stream!(trim: true)
    |> IO.inspect()
    |> Enum.map(&String.to_integer(&1))
    |> IO.inspect()
  end

  def part_one(problem) do
    # find the pair of numbers that sum to 2020
    Enum.flat_map(
      Enum.with_index(problem),
      fn {x, i} ->
        Enum.slice(problem, (i + 1)..-1//1)
        |> Enum.map(fn y ->
          if x + y == 2020 do
            x * y
          else
            0
          end
        end)
      end
    )
    |> Enum.sum()
  end

  def part_two(problem) do
    Enum.flat_map(Enum.with_index(problem), fn {x, i} ->
      Enum.map(Enum.slice(problem, (i + 1)..-1//1), fn y ->
        rest = 2020 - x - y

        if Enum.member?(problem, rest) do
          x * y * rest
        else
          0
        end
      end)
    end)
  end
end
