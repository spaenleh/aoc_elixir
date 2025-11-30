defmodule AocElixir.Solutions.Y15.Day01 do
  alias AoC.Input

  def parse(input, _part) do
    Input.read!(input)
    |> String.split("")
  end

  def part_one(problem) do
    problem
    |> Enum.frequencies()
    |> then(fn map ->
      Map.get(map, "(", 0) - Map.get(map, ")", 0)
    end)
  end

  # def part_two(problem) do
  #   problem
  # end
end
