defmodule AocElixir.Solutions.Y25.Day09 do
  alias AoC.Input

  def parse(input, _part) do
    Input.stream_file_lines(input, trim: true)
    |> Stream.map(&(String.split(&1, ",") |> Enum.map(fn v -> v |> String.to_integer() end)))
  end

  def part_one(problem) do
    # {[min_x, _], [max_x, _]} =
    #   problem
    #   |> Enum.min_max_by(fn v -> Enum.at(v, 0) end)
    #
    # {[_, min_y], [_, max_y]} =
    #   problem
    #   |> Enum.min_max_by(fn v -> Enum.at(v, 1) end)

    problem
    # |> Enum.filter(fn [px, py] ->
    #   px == min_x or py == min_y or px == max_x or py == max_y
    # end)
    |> unique_pairs(&area/1)
    # |> IO.inspect(label: "pairs", charlists: false)
    |> Enum.max_by(&elem(&1, 1))
    |> elem(1)
  end

  defp area({[ax, ay], [bx, by]}) do
    (abs(bx - ax) + 1) * (abs(ay - by) + 1)
  end

  def unique_pairs(list, func) do
    list
    |> Enum.with_index()
    |> Enum.flat_map(fn {a, i} ->
      list
      |> Enum.drop(i + 1)
      |> Enum.map(fn b ->
        couple = {a, b}
        {couple, func.(couple)}
      end)
    end)
  end

  # def part_two(problem) do
  #   problem
  # end
end
