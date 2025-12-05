defmodule AocElixir.Solutions.Y25.Day05Test do
  alias AoC.Input, warn: false
  alias AocElixir.Solutions.Y25.Day05, as: Solution, warn: false
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
    3-5
    10-14
    16-20
    12-18

    1
    5
    8
    11
    17
    32
    """

    assert 3 == solve(input, :part_one)
  end

  @part_one_solution 617
  @tag :solution
  test "part one solution" do
    assert {:ok, @part_one_solution} == AoC.run(2025, 5, :part_one)
  end

  @tag :only
  test "part two example" do
    input = ~S"""
    3-5
    10-14
    16-20
    12-18

    1
    5
    8
    11
    17
    32
    """

    assert 14 == solve(input, :part_two)
    # amount to a zero length range
    assert 6 ==
             solve(
               ~S"""
               3-5
               4-5
               5-8
               6-7

               1
               """,
               :part_two
             )
  end

  # 327327831946291 -> too low
  @part_two_solution 338_258_295_736_104

  test "part two solution" do
    assert {:ok, @part_two_solution} == AoC.run(2025, 5, :part_two)
  end
end
