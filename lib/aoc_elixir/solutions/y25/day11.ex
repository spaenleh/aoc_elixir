defmodule AocElixir.Solutions.Y25.Day11 do
  alias AoC.Input

  def parse(input, :part_two) do
    Input.stream_file_lines(input, trim: true)
    |> Stream.map(fn line ->
      [node, out_nodes] = line |> String.split(": ")

      {
        node,
        out_nodes
        |> String.split(" ")
      }
    end)
    |> Map.new()
  end

  def parse(input, _part) do
    Input.stream_file_lines(input, trim: true)
    |> Stream.map(fn line ->
      [node, out_nodes] = line |> String.split(": ")

      {
        node,
        out_nodes
        |> String.split(" ")
        |> MapSet.new()
      }
    end)
    |> Map.new()
  end

  def part_one(graph) do
    graph
    |> traverse(MapSet.new(), "you", :part_one)
  end

  defp traverse(graph, visited_nodes, current_node, part) do
    cond do
      current_node == "out" ->
        case part do
          :part_two ->
            if MapSet.member?(visited_nodes, "dac") and MapSet.member?(visited_nodes, "fft") do
              1
            else
              0
            end

          _ ->
            1
        end

      MapSet.member?(visited_nodes, current_node) ->
        # We have already visited this node
        0

      true ->
        # add the current_node to the visited_nodes
        visited_nodes = MapSet.put(visited_nodes, current_node)
        # We haven't visited anything yet, start with the "you" node

        Map.get(graph, current_node, [])
        |> Enum.reject(fn n -> n == current_node end)
        |> Enum.map(fn next_node ->
          traverse(graph, visited_nodes, next_node, part)
        end)
        |> Enum.sum()
    end
  end

  def part_two_naive(graph) do
    graph |> traverse(MapSet.new(), "svr", :part_two)
  end

  def part_two(graph) do
    count_paths_via_any_order(graph, "svr", "dac", "fft", "out")
  end

  def count_paths_via_any_order(adj, s, a, b, t) do
    # Count both orders and add
    term1 = count_paths(adj, s, a) * count_paths(adj, a, b) * count_paths(adj, b, t)
    term2 = count_paths(adj, s, b) * count_paths(adj, b, a) * count_paths(adj, a, t)
    term1 + term2
  end

  # Memoized DFS count from u to t on a DAG
  defp count_paths(adj, u, t) do
    cache = :ets.new(:paths_cache, [:set, :private])

    try do
      dfs_count(u, t, adj, cache)
    after
      :ets.delete(cache)
    end
  end

  defp dfs_count(u, t, adj, cache) do
    case :ets.lookup(cache, {u, t}) do
      [{_, val}] ->
        val

      [] ->
        val =
          if u == t do
            1
          else
            Enum.reduce(Map.get(adj, u, []), 0, fn v, acc ->
              acc + dfs_count(v, t, adj, cache)
            end)
          end

        :ets.insert(cache, {{u, t}, val})
        val
    end
  end
end
