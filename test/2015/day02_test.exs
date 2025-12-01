defmodule AocElixir.Solutions.Y15.Day02Test do
  alias AoC.Input, warn: false
  alias AocElixir.Solutions.Y15.Day02, as: Solution, warn: false
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
    2x3x4
    """

    assert 58 == solve(input, :part_one)

    assert 43 ==
             solve(
               ~S"""
               1x1x10
               """,
               :part_one
             )
  end

  @part_one_solution 1_606_483
  @tag :solution
  test "part one solution" do
    assert {:ok, @part_one_solution} == AoC.run(2015, 2, :part_one)
  end

  test "part two example" do
    assert 34 ==
             solve(
               ~S"""
               2x3x4
               """,
               :part_two
             )

    assert 14 ==
             solve(
               ~S"""
               1x1x10
               """,
               :part_two
             )
  end

  @part_two_solution 3_842_356
  @tag :solution
  test "part two solution" do
    assert {:ok, @part_two_solution} == AoC.run(2015, 2, :part_two)
  end
end
