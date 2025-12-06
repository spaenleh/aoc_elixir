defmodule AocElixir.Solutions.Y25.Day06Test do
  alias AoC.Input, warn: false
  alias AocElixir.Solutions.Y25.Day06, as: Solution, warn: false
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
    123 328  51 64 
     45 64  387 23 
      6 98  215 314
    *   +   *   + 
    """

    assert 4_277_556 == solve(input, :part_one)
  end

  @part_one_solution 6_891_729_672_676
  @tag :solutin
  test "part one solution" do
    assert {:ok, @part_one_solution} == AoC.run(2025, 6, :part_one)
  end

  @tag :only
  test "part two example" do
    input = ~S"""
    32 123  51 64 
    64  45 387 23 
    98   6 215 314
    +  *   *   + 
    """

    assert 3_263_819 == solve(input, :part_two)

    input = ~S"""
    123 328  51 64 
     45 64  387 23 
      6 98  215 314
    *   +   *   + 
    """

    assert 3_263_827 == solve(input, :part_two)
  end

  # 6641758960 too low
  # @part_two_solution CHANGE_ME
  #
  # test "part two solution" do
  #   assert {:ok, @part_two_solution} == AoC.run(2025, 6, :part_two)
  # end
end
