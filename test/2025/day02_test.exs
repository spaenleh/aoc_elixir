defmodule AocElixir.Solutions.Y25.Day02Test do
  alias AoC.Input, warn: false
  alias AocElixir.Solutions.Y25.Day02, as: Solution, warn: false
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
    11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
    """

    assert 1_227_775_554 == solve(input, :part_one)
  end

  @part_one_solution 30_608_905_813
  @tag :solution
  test "part one solution" do
    assert {:ok, @part_one_solution} == AoC.run(2025, 2, :part_one)
  end

  # test "part two example" do
  #   input = ~S"""
  #   11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
  #   """
  #
  #   assert 4_174_379_265 == solve(input, :part_two)
  # end

  # @part_two_solution CHANGE_ME
  #
  # test "part two solution" do
  #   assert {:ok, @part_two_solution} == AoC.run(2025, 2, :part_two)
  # end
end
