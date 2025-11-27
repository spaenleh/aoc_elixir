defmodule AocElixir.Solutions.Y24.Day01 do
  alias AoC.Input

  defp split_parse(string) do
    string
    |> String.split()
    |> Enum.map(fn str ->
      {nbr, _} = Integer.parse(str)
      nbr
    end)
  end

  def parse(input, _part) do
    Input.stream!(input, trim: true)
    |> Stream.map(&split_parse/1)
  end

  def part_one(problem) do
    problem
    |> Enum.map(fn [a, b] -> abs(b - a) end)
    |> Enum.sum()
  end

  # def part_two(problem) do
  #   problem
  # end
end
