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
        into: %{},
        do: {{r, c}, MapSet.new(Grid.neighbors_coord_where(grid, r, c, value))}
  end

  def reduce_to(graph, opts) do
    k = Keyword.get(opts, :k, 4)

    initial_queue =
      Enum.reduce(graph, :queue.new(), fn
        {node, degrees}, q ->
          if MapSet.size(degrees) < k do
            :queue.in(node, q)
          else
            q
          end
      end)

    perform_reduction(graph, initial_queue, k)
  end

  defp perform_reduction(graph, queue, k) do
    case :queue.out(queue) do
      {{:value, value}, q} ->
        # drop the node from all its neighbours

        # check neighbours that may have now less than k degrees
        node = Map.get(graph, value)

        {new_graph, new_queue} =
          node
          |> Enum.reduce({graph, q}, fn node, {g, qq} ->
            n_q =
              if MapSet.size(Map.get(g, node)) < k do
                :queue.in(node, qq)
              else
                qq
              end

            {Map.put(g, node, MapSet.delete(Map.get(graph, node), value)), n_q}
          end)

        perform_reduction(new_graph, new_queue, k)

      {:empty, _q} ->
        graph
    end
  end
end
