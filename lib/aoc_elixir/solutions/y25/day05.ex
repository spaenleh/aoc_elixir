defmodule AocElixir.Solutions.Y25.Day05 do
  alias AoC.Input

  def parse(input, :part_two) do
    [ranges, _ingredients] =
      Input.read!(input)
      |> String.split("\n\n")

    ranges
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn range ->
      [lh, rh] =
        String.split(range, "-")

      {String.to_integer(lh), String.to_integer(rh)}
    end)
  end

  def parse(input, _part) do
    [ranges, ingredients] =
      Input.read!(input)
      |> String.split("\n\n")

    ranges =
      ranges
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn range ->
        [lh, rh] =
          String.split(range, "-")

        {String.to_integer(lh), String.to_integer(rh)}
      end)

    ingredients =
      ingredients
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn v ->
        String.to_integer(v)
      end)

    {ranges, ingredients}
  end

  def part_one({ranges, ingredients}) do
    ingredients
    |> Enum.filter(fn ingredient ->
      ranges
      |> Enum.reduce_while(false, fn
        {lh, rh}, _ when ingredient >= lh and ingredient <= rh -> {:halt, true}
        _, _acc -> {:cont, false}
      end)
    end)
    |> length()
  end

  def part_two(ranges) do
    ranges
    |> Enum.sort(fn {lha, rha}, {lhb, rhb} ->
      cond do
        lha < lhb -> true
        lha == lhb -> rha < rhb
        true -> false
      end
    end)
    |> Enum.scan({0, 0}, fn {low, high}, {max_seen, _v} ->
      cond do
        # new lower bound is strictly bigger than previous higer bound
        low > max_seen -> {high, high - low + 1}
        low <= max_seen and high >= max_seen -> {high, high - max_seen}
        # both are smaller, the range is null
        true -> {max_seen, 0}
      end
    end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end
end
