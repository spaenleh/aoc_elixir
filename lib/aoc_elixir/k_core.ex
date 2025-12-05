defmodule AocElixir.KCore do
  @moduledoc """
  This module implements the k-core algorithm for finding clusters of in a graph that will survive with k connections.
  """

  alias AocElixir.Grid

  @doc """
  Returns the adjacency list of the nodes in the grid.

  ## Example
    iex> adjacency_list([[".", "@"],
                         ["@", "@"],
                         [".", "."]], "@")

  """
  def adjacency_list(grid, value) do
    for {row, r} <- Enum.with_index(grid),
        {_col, c} <- Enum.with_index(row),
        Grid.at(grid, r, c) == value,
        into: %{},
        do: {{c, r}, MapSet.new(Grid.neighbors_coord_where(grid, r, c, value))}
  end

  def perform(grid) do
    k = 4
    graph = adjacency_list(grid, "@")

    dying_cells =
      graph
      |> Enum.filter(fn {_node, neighbours} ->
        # node |> IO.inspect(label: "node")

        degree =
          MapSet.size(neighbours)

        # |> IO.inspect(label: "degree")

        degree < k
      end)

    # |> IO.inspect()

    case length(dying_cells) do
      # nothing to remove, we are done
      0 ->
        # Grid.display(grid)
        map_size(graph)

      # we remove the coords that are less than 3 degrees  
      _ ->
        dying_cells
        |> Enum.reduce(grid, fn {coord, _}, g ->
          # apply grid transform 
          Grid.update(g, coord, ".")
        end)
        # call recursively
        |> perform()
    end
  end

  def reduce_to(graph, opts) do
    k = Keyword.get(opts, :k, 4)

    initial_queue =
      graph
      |> Enum.reduce(:queue.new(), fn
        {node, neighbours}, q ->
          # IO.inspect(%{node: node, degree: MapSet.size(neighbours)}, label: "")

          if MapSet.size(neighbours) < k do
            :queue.in(node, q)
          else
            q
          end
      end)
      |> IO.inspect(label: "initial queue")

    perform_reduction(graph, initial_queue, k)
  end

  defp perform_reduction(step_graph, input_q, k) do
    case :queue.out(input_q) do
      {{:value, value}, res_q} ->
        value |> IO.inspect(label: "out node")
        # check neighbours that may have now less than k degrees
        nodes =
          Map.get(step_graph, value, [])
          |> IO.inspect(label: "linked nodes")

        {new_graph, new_queue} =
          case nodes do
            # the node is alone, do nothing
            nil ->
              {step_graph, res_q}

            # node has neighbours still, we need to update them
            _ ->
              nodes
              |> Enum.reduce({step_graph, res_q}, fn node, {g, qq} ->
                IO.puts("  node: #{inspect(node)}, #{get_degree(g, node)}")

                # remove the dequeued node from the node neighbours
                new_node_neighbours = MapSet.delete(Map.get(g, node), value)

                n_q =
                  if get_degree(g, node) < k do
                    # enqueue the node since it has a degree less than k
                    IO.puts("    enqueue node")
                    :queue.in(node, qq)
                  else
                    qq
                  end

                # update the graph with the new node's neighbours
                n_g =
                  Map.put(g, node, new_node_neighbours)
                  |> IO.inspect(label: "    new graph")

                {n_g, n_q}
              end)
          end

        # finish by removing the dequeue node from the graph
        next_iter_graph = Map.delete(new_graph, value)

        perform_reduction(next_iter_graph, new_queue, k)

      {:empty, _q} ->
        step_graph
    end
  end

  defp get_degree(graph, node) do
    with true <- Map.has_key?(graph, node), neighbours <- Map.get(graph, node) do
      MapSet.size(neighbours)
    end
  end
end
