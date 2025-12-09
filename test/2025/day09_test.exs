defmodule AocElixir.Solutions.Y25.Day09Test do
  alias AoC.Input, warn: false
  alias AocElixir.Solutions.Y25.Day09, as: Solution, warn: false
  use ExUnit.Case, async: true

  defp solve(input, part) do
    problem =
      input
      |> Input.as_file()
      |> Solution.parse(part)

    apply(Solution, part, [problem])
  end

  test "part one example" do
    input = ~S"""
    7,1
    11,1
    11,7
    9,7
    9,5
    2,5
    2,3
    7,3
    """

    assert 50 == solve(input, :part_one)
  end

  @part_one_solution 4_755_429_952
  @tag :solution
  test "part one solution" do
    assert {:ok, @part_one_solution} == AoC.run(2025, 9, :part_one)
  end

  # test "part two example" do
  #   input = ~S"""
  #   7,1
  #   11,1
  #   11,7
  #   9,7
  #   9,5
  #   2,5
  #   2,3
  #   7,3
  #   """
  #
  #   assert 24 == solve(input, :part_two)
  # end

  # @part_two_solution CHANGE_ME
  #
  # test "part two solution" do
  #   assert {:ok, @part_two_solution} == AoC.run(2025, 9, :part_two)
  # end
end
