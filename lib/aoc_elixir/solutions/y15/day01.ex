defmodule AocElixir.Solutions.Y15.Day01 do
  alias AoC.Input

  def parse(input, _part) do
    Input.read!(input)
    |> String.split("")
    |> Enum.reject(fn el -> el == "" end)
  end

  def part_one(problem) do
    problem
    |> Enum.frequencies()
    |> then(fn map ->
      Map.get(map, "(", 0) - Map.get(map, ")", 0)
    end)
  end

  def part_two(problem) do
    Enum.reduce_while(problem, {0, 0}, fn op, {level, index} ->
      level =
        if op == "(" do
          level + 1
        else
          level - 1
        end

      if level == -1 do
        {:halt, index + 1}
      else
        {
          :cont,
          {level, index + 1}
        }
      end
    end)
  end
end
