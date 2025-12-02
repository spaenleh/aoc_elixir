defmodule AocElixir.Solutions.Y25.Day02 do
  alias AoC.Input

  def parse(input, _part) do
    Input.read!(input)
    |> String.trim()
    |> String.split(",")
  end

  def part_one(problem) do
    problem
    |> Enum.map(&String.split(&1, "-"))
    # |> IO.inspect()
    |> Enum.map(fn [start_val, end_val] ->
      String.to_integer(start_val)..String.to_integer(end_val)
      |> Enum.reject(fn id ->
        # ID that is even can not be fake
        id_string = Integer.to_charlist(id)
        id_length = length(id_string)
        # IO.puts("#{id_length}, #{mid}, #{start_string}, #{end_string}")

        case id do
          _ when id < 11 ->
            true

          _ when rem(id_length, 2) != 0 ->
            # IO.puts("odd size")
            true

          _ ->
            mid = div(id_length, 2)
            start_string = String.slice("#{id_string}", 0..(mid - 1))
            end_string = String.slice("#{id_string}", mid..-1//1)

            !(start_string == end_string)
        end
      end)
    end)
    |> Enum.flat_map(& &1)
    # |> Enum.map(&IO.inspect(&1))
    |> Enum.sum()
  end

  # def part_two(problem) do
  #   problem
  # end
end
