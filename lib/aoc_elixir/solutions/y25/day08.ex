defmodule AocElixir.Solutions.Y25.Day08 do
  alias AoC.Input

  def parse(input, :part_one) do
    max_iter =
      case input do
        %Input.TestInput{} -> 10
        _ -> 1000
      end

    {input |> get_boxes(), max_iter}
  end

  def parse(input, _) do
    input |> get_boxes()
  end

  defp get_boxes(input) do
    Input.stream_file_lines(input, trim: true)
    |> Enum.map(fn line ->
      line |> String.split(",") |> Enum.map(&String.to_integer(&1))
    end)
  end

  def part_one({problem, max_iter}) do
    problem
    |> unique_pairs
    |> Enum.sort(fn {_x, dist_1}, {_y, dist_2} -> dist_1 <= dist_2 end)
    |> Enum.map(&elem(&1, 0))
    |> create_iter_circuits(max_iter)
    |> Enum.map(fn set -> MapSet.size(set) end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  @doc """
  Create all ordered paires from the list.
  """
  def unique_pairs(list) do
    list
    |> Enum.with_index()
    |> Enum.flat_map(fn {a, i} ->
      list
      |> Enum.drop(i + 1)
      |> Enum.map(fn b ->
        {{a, b}, euclid_distance(a, b)}
      end)
    end)
  end

  def euclid_distance([x1, y1, z1], [x2, y2, z2]) do
    x = x1 - x2
    y = y1 - y2
    z = z1 - z2
    x * x + y * y + z * z
  end

  def create_iter_circuits(pairs, max_iter) when is_list(pairs) do
    pairs
    |> Enum.reduce_while({0, []}, fn {a, b}, {iter, sets} ->
      if iter >= max_iter do
        {:halt, sets}
      else
        {:cont, {iter + 1, new_set(a, b, sets)}}
      end
    end)
  end

  defp new_set(a, b, sets) do
    {matching, non_matching} =
      Enum.split_with(sets, fn set ->
        MapSet.member?(set, a) or MapSet.member?(set, b)
      end)

    case matching do
      # No overlap: start a new set with both
      [] ->
        [MapSet.new([a, b]) | non_matching]

      # One or more overlaps: merge them all with the new pair
      _ ->
        merged =
          matching
          |> Enum.reduce(MapSet.new([a, b]), fn set, acc ->
            MapSet.union(acc, set)
          end)

        [merged | non_matching]
    end
  end

  def part_two(problem) do
    num_boxes = problem |> length()

    problem
    |> unique_pairs
    |> Enum.sort(fn {_x, dist_1}, {_y, dist_2} -> dist_1 <= dist_2 end)
    |> Enum.map(&elem(&1, 0))
    |> create_circuits(num_boxes)
  end

  def create_circuits(pairs, num_nodes) when is_list(pairs) do
    pairs
    |> Enum.reduce_while([], fn {a, b}, sets ->
      n_sets = new_set(a, b, sets)

      if Enum.at(n_sets, 0) |> MapSet.size() == num_nodes do
        {:halt, Enum.at(a, 0) * Enum.at(b, 0)}
      else
        {:cont, n_sets}
      end
    end)
  end
end
