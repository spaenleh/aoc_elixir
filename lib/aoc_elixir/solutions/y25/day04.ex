defmodule AocElixir.Solutions.Y25.Day04 do
  alias AocElixir.KCore
  alias AocElixir.Grid
  alias AoC.Input

  def parse(input, _part) do
    Input.stream_file_lines(input, trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split("")
      |> Enum.filter(fn char ->
        case char do
          "" -> false
          _ -> true
        end
      end)
    end)
  end

  def part_one(problem) do
    coords = problem |> Grid.where("@")

    coords
    |> Enum.map(fn {x, y} ->
      Grid.neighbors(problem, x, y) |> is_movable?(fn val -> val == "@" end)
    end)
    |> Enum.sum_by(fn v ->
      case v do
        true -> 1
        _ -> 0
      end
    end)
  end

  def is_movable?(list, matcher) do
    Enum.count(list, matcher) < 4
  end

  def part_two(grid) do
    initial_nodes = grid |> Grid.to_graph("@") |> map_size()

    final_nodes =
      grid
      |> KCore.perform()

    initial_nodes - final_nodes
  end

  def k_core(grid) do
    grid
    |> Grid.to_graph("@")
    |> KCore.reduce(k: 4)
    |> map_size()
  end
end
