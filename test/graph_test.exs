defmodule AocElixir.GraphTest do
  use ExUnit.Case, async: true

  alias AocElixir.Graph

  test "delete/2 removes node from graph" do
    graph = %{
      a: MapSet.new([:c, :b, :e]),
      b: MapSet.new([:a, :d]),
      c: MapSet.new([:a, :e]),
      d: MapSet.new([:b]),
      e: MapSet.new([:f, :a, :c]),
      f: MapSet.new([:e])
    }

    assert Graph.delete(graph, :f) == %{
             c: MapSet.new([:a, :e]),
             b: MapSet.new([:a, :d]),
             a: MapSet.new([:c, :b, :e]),
             d: MapSet.new([:b]),
             e: MapSet.new([:a, :c])
           }

    assert Graph.delete(graph, :a) ==
             %{
               b: MapSet.new([:d]),
               c: MapSet.new([:e]),
               d: MapSet.new([:b]),
               e: MapSet.new([:f, :c]),
               f: MapSet.new([:e])
             }
  end
end
