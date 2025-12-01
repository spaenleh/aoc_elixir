defmodule AocElixir.Solutions.Y25.Day01 do
  alias AoC.Input

  def to_struct(line) do
    case line do
      "L" <> value -> -1 * String.to_integer(value)
      "R" <> value -> String.to_integer(value)
      _ -> 0
    end
  end

  def parse(input, _part) do
    Input.stream!(input, trim: true)
    |> Stream.map(&to_struct/1)
  end

  def part_one(problem) do
    problem
    |> Enum.reduce(%{zero: 0, pos: 50}, fn value, acc ->
      new_pos =
        Integer.mod(acc.pos + value, 100)

      # check if stopped on 0
      num_zero =
        if new_pos == 0 do
          acc.zero + 1
        else
          acc.zero
        end

      %{pos: new_pos, zero: num_zero}
    end)
    |> then(fn %{zero: num_zero} -> num_zero end)
  end

  def part_two(problem) do
    problem
    |> Enum.reduce(%{zero: 0, pos: 50}, fn value, acc ->
      # is the value a complement to the current pos -> we end on zero
      value_rem = rem(value, 100)
      pos_complement = acc.pos + value_rem

      is_complement =
        if pos_complement == 0 or pos_complement == 100 do
          1
        else
          0
        end

      # this is the number of full turns that it can make
      full_turns =
        div(abs(value), 100)

      # if we start on zero and finish on zero, we need to take one out of the turns (if there are at least one) 
      rectified_full_turns =
        if acc.pos == 0 and is_complement == 1 and full_turns > 0 do
          full_turns - 1
        else
          full_turns
        end

      is_crossing =
        if (acc.pos > 0 and pos_complement < 0) or pos_complement > 100 do
          1
        else
          0
        end

      num_zero = acc.zero + rectified_full_turns + is_complement + is_crossing

      new_pos =
        Integer.mod(acc.pos + value, 100)

      %{pos: new_pos, zero: num_zero}
    end)
    |> then(fn %{zero: num_zero} -> num_zero end)
  end
end
