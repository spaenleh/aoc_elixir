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
      # IO.puts("---\npos: #{acc.pos}, value: #{value}")

      new_pos =
        Integer.mod(acc.pos + value, 100)

      # this is the number of full turns that it can make
      full_turns = div(abs(value), 100)
      # |> IO.inspect(label: "will_turn")
      # is the value a complement to the current pos -> we end on zero
      value_rem = rem(value, 100)
      pos_complement = acc.pos + value_rem

      is_complement =
        if acc.pos != 0 and (pos_complement == 0 or pos_complement == 100) do
          1
        else
          0
        end

      num_zero = acc.zero + full_turns + is_complement
      IO.puts(num_zero)

      # num_zero = acc.zero
      # check if stopped on 0
      # num_zero =
      #   if new_pos == 0 do
      #     # IO.puts("Stops on 0")
      #     acc.zero + 1
      #   else
      #     acc.zero
      #   end

      # if the value is negative, we crossed 0
      # num_zero =
      #   if acc.pos > 0 and acc.pos + value < 0 do
      #     # IO.puts("goes past zero from + to -")
      #     x_times = abs(div(value, 100)) + 1
      #     # IO.puts("for #{x_times} times")
      #     num_zero + x_times
      #   else
      #     num_zero
      #   end
      #
      # num_zero =
      #   if acc.pos != 0 and acc.pos + value > 100 do
      #     num_zero + 1 + div(value, 100)
      #   else
      #     num_zero
      #   end
      #
      # # special case for when we are on zero, we do not want to count more than needed
      # num_zero =
      #   if acc.pos == 0 do
      #     num_zero + abs(div(value, 100)) + 1
      #   else
      #     num_zero
      #   end

      # IO.puts("num_zero: #{num_zero}")
      %{pos: new_pos, zero: num_zero}
    end)
    |> then(fn %{zero: num_zero} -> num_zero end)
  end
end
