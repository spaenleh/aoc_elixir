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
    |> Enum.scan({{0, 0}, 0}, fn {lha, rha}, {{lhb, rhb}, _acc} ->
      cond do
        # new lower bound is strictly bigger than previous higer bound
        lha > rhb -> {{lha, rha}, rha - lha + 1}
        lha <= rhb and rha >= rhb -> {{rhb + 1, rha}, rha - rhb}
        # both are smaller, the range is null
        true -> {{lhb, rhb}, 0}
      end
    end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end
end
