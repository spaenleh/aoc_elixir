defmodule AocElixir.Solutions.Y15.Day01Test do
  alias AoC.Input, warn: false
  alias AocElixir.Solutions.Y15.Day01, as: Solution, warn: false
  use ExUnit.Case, async: true

  defp solve(input, part) do
    problem =
      input
      |> Input.as_file()
      |> Solution.parse(part)

    apply(Solution, part, [problem])
  end

  test "part one example" do
    assert 3 == solve("))(((((", :part_one)
    assert 0 == solve("()()", :part_one)
    assert 0 == solve("(())", :part_one)
  end

  @part_one_solution 74

  test "part one solution" do
    assert {:ok, @part_one_solution} == AoC.run(2015, 1, :part_one)
  end

  test "part two example" do
    input = ~S"""
    This is an
    example input.
    replace with
    an example from
    the AoC website.
    """

    assert CHANGE_ME == solve(input, :part_two)
  end

  # @part_two_solution CHANGE_ME
  #
  # test "part two solution" do
  #   assert {:ok, @part_two_solution} == AoC.run(2015, 1, :part_two)
  # end
end
