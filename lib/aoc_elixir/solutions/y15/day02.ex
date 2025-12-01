defmodule AocElixir.Solutions.Y15.Day02 do
  alias AoC.Input

  def parse_sizes(line) do
    line |> String.split("x") |> Input.list_of_integers()
  end

  def parse(input, _part) do
    Input.stream!(input, trim: true)
    |> Stream.map(&parse_sizes/1)
  end

  def part_one(problem) do
    problem
    |> Enum.map(fn [l, w, h] ->
      sides = [l * w, w * h, l * h]
      2 * Enum.sum(sides) + Enum.min(sides)
    end)
    |> Enum.sum()
  end

  def part_two(problem) do
    problem
    |> Enum.map(fn [l, w, h] ->
      perim = [l + w, w + h, h + l]
      2 * Enum.min(perim) + l * h * w
    end)
    |> Enum.sum()
  end
end
