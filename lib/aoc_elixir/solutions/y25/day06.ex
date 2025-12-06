defmodule AocElixir.Solutions.Y25.Day06 do
  alias AoC.Input
  import AocElixir.Parsing, only: [whitespace: 1]

  def parse(input, :part_one) do
    Input.stream!(input, trim: true)
    |> Enum.map(fn line -> line |> String.split(" ") |> Enum.reject(&whitespace/1) end)
    |> Enum.reverse()
  end

  def parse(input, :part_two) do
    [ops | stacks] =
      Input.read!(input)
      |> String.split("\n")
      |> Enum.reject(&whitespace/1)
      |> Enum.reverse()

    ops = ops |> String.split(" ") |> Enum.reject(&whitespace/1)

    stacks =
      stacks
      |> Enum.reverse()
      |> Enum.map(fn line -> line |> String.split("") end)
      |> Enum.zip()
      |> Enum.map(fn num_tuple ->
        num_tuple
        |> Tuple.to_list()
        |> Enum.join("")
        |> String.trim()
      end)
      |> Enum.reduce({[], []}, fn
        "", {acc, current} ->
          # on empty string: if we have a current group, push it to acc and reset
          case current do
            [] -> {acc, []}
            _ -> {[current | acc], []}
          end

        item, {acc, current} ->
          {acc, [String.to_integer(item) | current]}
      end)
      |> then(fn {acc, current} ->
        # flush any trailing group after reduction

        case current do
          [] -> acc
          _ -> [current | acc]
        end
        |> Enum.reverse()
      end)

    {ops, stacks}
  end

  def part_one(problem) do
    [ops | vals] = problem

    vals
    |> Enum.zip()
    |> Enum.with_index()
    |> Enum.map(fn {stack, idx} ->
      stack = stack |> Tuple.to_list() |> Enum.map(&String.to_integer/1)

      case Enum.at(ops, idx) do
        "+" -> Enum.sum(stack)
        "*" -> Enum.product(stack)
        _ -> 0
      end
    end)
    |> Enum.sum()
  end

  def part_two({ops, stacks}) do
    stacks
    |> Enum.with_index()
    |> Enum.map(fn {stack, idx} ->
      case Enum.at(ops, idx) do
        "+" -> Enum.sum(stack)
        "*" -> Enum.product(stack)
        _ -> 0
      end
    end)
    |> Enum.sum()
  end
end
