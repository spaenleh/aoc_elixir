defmodule AocElixir.Solutions.Y25.Day07 do
  alias AoC.Input

  def parse(input, _part) do
    [start | lines] = Input.read!(input) |> String.trim() |> String.split("\n")

    s_index = start |> String.split("") |> Enum.find_index(&(&1 == "S"))
    {lines, [s_index]}
  end

  def part_one({lines, positions}) do
    # remove every other line
    splitter_lines =
      lines |> Enum.drop(1) |> Enum.take_every(2)

    splitter_lines
    |> Enum.scan({positions, 0}, &process_beam/2)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  def process_beam(line, {positions, _num_splits}) do
    spliter_positions =
      get_splitter_positions(line)

    splitting =
      MapSet.intersection(MapSet.new(spliter_positions), MapSet.new(positions))

    splitted_pos =
      splitting
      |> Enum.flat_map(fn pos ->
        [pos - 1, pos + 1]
      end)
      |> MapSet.new()

    new_positions =
      MapSet.union(MapSet.new(positions), splitted_pos)
      |> MapSet.difference(splitting)

    # check if there are new beams split
    {MapSet.to_list(new_positions), MapSet.size(splitting)}
  end

  defp get_splitter_positions(line) do
    line
    |> String.split("")
    |> Enum.with_index()
    |> Enum.filter(fn {v, _idx} -> v == "^" end)
    |> Enum.map(&elem(&1, 1))
  end

  def part_two({lines, positions}) do
    # remove every other line
    splitter_lines = for {val, idx} <- lines |> Enum.with_index(), rem(idx, 2) == 1, do: val
    positions = %{Enum.at(positions, 0) => 1}

    splitter_lines
    |> Enum.reduce(positions, &process_timelines/2)
    |> Map.values()
    |> Enum.sum()
  end

  def process_timelines(line, timelines) do
    spliter_positions =
      get_splitter_positions(line)

    spliter_positions
    |> Enum.reduce(timelines, fn pos, acc ->
      val_at_pos =
        Map.get(acc, pos, 0)

      Map.update(acc, pos - 1, 1, fn v -> v + val_at_pos end)
      |> Map.update(pos + 1, 1, fn v -> v + val_at_pos end)
      |> Map.put(pos, 0)
    end)
  end
end
