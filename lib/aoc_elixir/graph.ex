defmodule AocElixir.Graph do
  alias AocElixir.Grid

  defdelegate get(graph, node), to: Map

  def delete(graph, node) do
    neigh =
      get(graph, node)
      |> IO.inspect(label: "neighs")

    graph =
      case neigh do
        nil ->
          graph

        _ ->
          neigh
          |> Enum.reduce(graph, fn n, g ->
            Map.put(g, n, MapSet.delete(get(g, n), node))
          end)
      end

    # remove the node itself
    Map.delete(graph, node)
  end

  def display(graph) do
    graph
    |> Grid.from_graph("@")
    |> Grid.display()
  end
end
