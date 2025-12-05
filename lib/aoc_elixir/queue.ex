defmodule AocElixir.Queue do
  @moduledoc """
  FIFO queue implemented with two lists for amortized O(1) enqueue/dequeue.

  Structure:
    - `in`: list of newly enqueued items (top at head)
    - `out`: list of items ready to dequeue (top at head)

  Invariant:
    - If `out` is empty and `in` is non-empty, we move all items from `in` to `out` by reversing `in`.

  This design ensures:
    - Enqueue: O(1) prepend to `in`
    - Dequeue: O(1) pop from `out`, with occasional O(n) refill amortized to O(1)
  """

  @type t :: %{in: [any()], out: [any()]}

  @doc "Create a new empty queue"
  @spec new() :: t()
  def new, do: %{in: [], out: []}

  @doc "Enqueue an item, returns the new queue"
  @spec enqueue(t(), any()) :: t()
  def enqueue(%{in: i, out: o} = _q, item) do
    %{in: [item | i], out: o}
  end

  @doc """
  Dequeue an item.

  Returns:
    - {:ok, item, new_queue}
    - :empty
  """
  @spec dequeue(t()) :: {:ok, any(), t()} | :empty
  def dequeue(%{in: [], out: []}), do: :empty

  # Fast path: pop from out if available
  def dequeue(%{in: i, out: [h | t]}) do
    {:ok, h, %{in: i, out: t}}
  end

  # Refill out from in when out is empty
  def dequeue(%{in: i, out: []}) do
    # Move all from `in` to `out` by reversing `in`
    out = :lists.reverse(i)

    case out do
      [] -> :empty
      [h | t] -> {:ok, h, %{in: [], out: t}}
    end
  end

  @doc """
  Return all elements in FIFO order as a list.

  Implementation detail:
    - `out` is already in dequeue order.
    - `in` holds newest-first; reverse it to get oldest-first and append after `out`.
  """
  @spec to_list(t()) :: [any()]
  def to_list(%{in: i, out: o}) do
    o ++ :lists.reverse(i)
  end
end
