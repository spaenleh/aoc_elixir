defmodule AocElixir.Solutions.Y24.Day01 do
  alias AoC.Input
  alias AocElixir.Parsing

  def parse(input, _part) do
    Input.stream!(input, trim: true)
    |> Stream.map(&Parsing.numbers_on_line/1)
  end

  def part_one(problem) do
    problem
    |> Stream.zip_with(fn list ->
      Enum.sort(list)
    end)
    |> Stream.zip()
    |> Stream.map(fn {a, b} -> abs(b - a) end)
    |> Enum.sum()
  end

  def part_two(problem) do
    problem
    |> Enum.zip_with(fn list ->
      Enum.frequencies(list)
    end)
    |> then(fn [dict, freq] ->
      Map.to_list(dict)
      |> Enum.map(fn {key, val} ->
        key * Map.get(freq, key, 0) * val
      end)
    end)
    |> Enum.sum()
  end
end
