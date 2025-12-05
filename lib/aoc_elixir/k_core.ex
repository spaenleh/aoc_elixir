defmodule AocElixir.KCore do
  @moduledoc """
  This module implements the k-core algorithm for finding clusters of in a graph that will survive with k connections.
  """

  alias AocElixir.Grid
  alias AocElixir.Graph
  alias AocElixir.Queue
  #
  # @doc """
  # Returns the adjacency list of the nodes in the grid.
  #
  # ## Example
  #   iex> adjacency_list([[".", "@"],
  #                        ["@", "@"],
  #                        [".", "."]], "@")
  #
  # """
  # def adjacency_list(grid, value) do
  #   for {row, r} <- Enum.with_index(grid),
  #       {_col, c} <- Enum.with_index(row),
  #       Grid.at(grid, r, c) == value,
  #       into: %{},
  #       do: {{c, r}, %{neighbours: MapSet.new(Grid.neighbors_coord_where(grid, r, c, value))}
  # end

  @doc """
  This function takes a Grid and perform the k-core algo on it.

  K can be sepcified as an option.

  It uses the iterative approache where  it gets all nodes
  that have a degree less than k and removes them from the grid,
  then it re-computes the graph to remove the next nodes.
  """
  def perform(grid, opts \\ []) do
    k =
      get_k_from_options(opts)

    graph = Grid.to_graph(grid, "@")

    dying_cells =
      graph
      |> Enum.filter(fn {_node, neighbours} ->
        degree =
          MapSet.size(neighbours)

        degree < k
      end)

    case length(dying_cells) do
      # nothing to remove, we are done
      0 ->
        map_size(graph)

      # we remove the coords that are less than 3 degrees  
      _ ->
        dying_cells
        |> Enum.reduce(grid, fn {coord, _}, g ->
          # apply grid transform 
          Grid.update(g, coord, ".")
        end)
        # call recursively
        |> perform(k: k)
    end
  end

  @doc """
  Performs the k-core algo only on the graph.

  It uses a FIFO queue to process nodes and adds nodes that fall
  short on the degree to the queue.

  Once the queue is done processing, we have our k-core nodes.

  """
  def reduce(graph, opts \\ []) do
    k = get_k_from_options(opts)
    IO.inspect(graph)

    {queue, graph} =
      update_queue(Queue.new(), graph, k)

    # graph |> Grid.from_graph("@") |> Grid.display(Queue.to_list(initial_queue))

    perform_reduction(graph, queue, k, 0)
  end

  defp perform_reduction(graph, queue, k, iter) do
    case Queue.dequeue(queue) do
      {:ok, node, queue} ->
        graph = graph |> Graph.delete(node)
        {queue, graph} = update_queue(queue, graph, k)

        # IO.puts("- Graph state -")
        # graph |> Grid.from_graph("@") |> Grid.display(Queue.to_list(queue))
        # IO.puts("\n")

        perform_reduction(graph, queue, k, iter + 1)

      :empty ->
        graph
    end
  end

  defp update_queue(queue, graph, k) do
    graph
    |> Enum.reduce({queue, graph}, fn
      {node, %{neighbours: neighbours, in_queue: in_queue}}, q ->
        if MapSet.size(neighbours) < k and not in_queue do
          {Queue.enqueue(q, node),
           Map.put(graph, node, %{neighbours: neighbours, in_queue: true})}
        else
          {q, graph}
        end
    end)
    |> IO.inspect()
  end

  defp get_k_from_options(opts) do
    Keyword.get(opts, :k, 4)
  end
end
