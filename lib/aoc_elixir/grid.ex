defmodule AocElixir.Grid do
  @neighbours_offsets [
    {-1, -1},
    {-1, 0},
    {-1, 1},
    {0, -1},
    {0, 1},
    {1, -1},
    {1, 0},
    {1, 1}
  ]
  def display(grid) do
    grid
    |> Enum.map(fn line ->
      Enum.join(line, "")
    end)
    |> Enum.join("\n")
    |> IO.puts()
  end

  def neighbors(grid, row, col) when is_list(grid) and is_integer(row) and is_integer(col) do
    Enum.map(@neighbours_offsets, fn {dr, dc} ->
      r =
        row + dr

      c = col + dc
      at(grid, r, c)
    end)
    |> Enum.filter(& &1)
  end

  def neighbors_coord_where(grid, row, col, value)
      when is_list(grid) and is_integer(row) and is_integer(col) and is_binary(value) do
    for {dr, dc} <- @neighbours_offsets,
        r = row + dr,
        c = col + dc,
        at(grid, r, c) == value,
        do: {c, r}
  end

  def at(_grid, row, col) when row < 0 or col < 0, do: nil

  def at(grid, row, col) do
    with {:ok, row_list} <- Enum.fetch(grid, row),
         {:ok, val} <- Enum.fetch(row_list, col) do
      val
    else
      _ -> nil
    end
  end

  def where(grid, char) when is_binary(char) do
    for {row, r} <- Enum.with_index(grid),
        {cell, c} <- Enum.with_index(row),
        cell == char,
        do: {r, c}
  end

  def update(grid, {x, y}, value) do
    put_in(grid, [Access.at(y), Access.at(x)], value)
  end

  def from_adjacency(graph, marker, opts \\ []) do
    # get all the coords from the graph
    coords = Map.keys(graph) |> IO.inspect()
    x_max = coords |> Enum.map(&elem(&1, 0)) |> Enum.max()
    y_max = coords |> Enum.map(&elem(&1, 1)) |> Enum.max()

    empty_value = Keyword.get(opts, :bg, ".")
    width = Keyword.get(opts, :width, x_max)
    height = Keyword.get(opts, :height, y_max)

    0..height
    |> Enum.map(fn y ->
      0..width
      |> Enum.map(fn x ->
        if Enum.member?(coords, {x, y}) do
          marker
        else
          empty_value
        end
      end)
    end)
  end
end
