defmodule AocElixir.Solutions.Y25.Day12 do
  alias AoC.Input

  def parse(input, _part) do
    parts =
      Input.read!(input)
      |> String.trim()
      |> String.split("\n\n")

    {presents, [raw_regions]} = parts |> Enum.split(-1)

    shapes =
      presents
      |> Enum.map(fn block ->
        shape =
          block
          |> String.split("\n")
          |> Enum.drop(1)

        shape_size =
          shape
          |> Enum.join("")
          |> String.graphemes()
          |> Enum.count(&(&1 == "#"))

        shape_size
      end)

    regions =
      raw_regions
      |> String.split("\n")
      |> Enum.map(fn line ->
        [dims, arangement] =
          line
          |> String.split(": ")

        total_area =
          dims |> String.split("x") |> Enum.map(&String.to_integer(&1)) |> Enum.product()

        arr = arangement |> String.split(" ") |> Enum.map(&String.to_integer(&1))
        {total_area, arr}
      end)

    {shapes, regions}
  end

  def part_one({shapes, regions}) do
    regions
    |> Enum.filter(fn {max_area, r} ->
      # need to determin if presents can fit in region
      planned_area =
        Enum.zip(r, shapes)
        |> Enum.map(fn {coef, s_area} -> coef * s_area end)
        |> Enum.sum()

      max_area > planned_area
    end)
    |> length()
  end

  # def part_two(problem) do
  #   problem
  # end
end
