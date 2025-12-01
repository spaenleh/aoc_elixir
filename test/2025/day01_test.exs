defmodule AocElixir.Solutions.Y25.Day01Test do
  alias AoC.Input, warn: false
  alias AocElixir.Solutions.Y25.Day01, as: Solution, warn: false
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
    L68
    L30
    R48
    L5
    R60
    L55
    L1
    L99
    R14
    L82
    """

    assert 3 == solve(input, :part_one)
  end

  @part_one_solution 969
  @tag :solution
  test "part one solution" do
    assert {:ok, @part_one_solution} == AoC.run(2025, 1, :part_one)
  end

  test "part two example" do
    input = ~S"""
    L68
    L30
    R48
    L5
    R60
    L55
    L1
    L99
    R14
    L82
    """

    assert 6 == solve(input, :part_two)
  end

  test "part two double crossing in positive" do
    input = ~S"""
    L68
    L30
    R48
    L5
    R160
    L55
    L1
    L99
    R14
    L82
    """

    assert 7 == solve(input, :part_two)
  end

  test "part two double zero" do
    input = ~S"""
    L68
    L30
    R48
    R200
    L5
    R160
    L55
    L1
    L99
    R14
    L82
    """

    assert 9 == solve(input, :part_two)
  end

  test "part two zero stay" do
    input = ~S"""
    L50
    L200
    """

    assert 3 == solve(input, :part_two)
  end

  test "part two zero and a little more" do
    input = ~S"""
    L50
    L201
    """

    assert 3 == solve(input, :part_two)
  end

  test "unit positive complement" do
    # lands on 0 via complement
    assert 1 ==
             solve(
               ~S"""
               R50
               """,
               :part_two
             )

    # full turn and lands on zero
    assert 2 ==
             solve(
               ~S"""
               R150
               """,
               :part_two
             )

    # add a complete turn in oposite  
    assert 3 ==
             solve(
               ~S"""
               R150
               L100
               """,
               :part_two
             )

    assert 4 ==
             solve(
               ~S"""
               R150
               L200
               """,
               :part_two
             )

    assert 4 ==
             solve(
               ~S"""
               R150
               L1
               L199
               """,
               :part_two
             )

    assert 4 ==
             solve(
               ~S"""
               R151
               L1
               L200
               """,
               :part_two
             )
  end

  # 59xx too high
  # 5767 too low
  # 5869 not correct
  #
  # @part_two_solution CHANGE_ME
  #
  # test "part two solution" do
  #   assert {:ok, @part_two_solution} == AoC.run(2025, 1, :part_two)
  # end
end
