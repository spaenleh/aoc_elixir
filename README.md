# Advent of code in Elixir

This is my solutions for advent of code in Elixir

I have started this repo to write my solutions in elixir.

This year (2025) I will attempt to solve the puzzles in Elixir.

## 2025

### 2025 Day 01

## 2024

### 2024 Day 01

This puzzle made me exercise the use of `Stream.zip/1` and `Stream.zip_with/2` to move from a row to a column representation.
This was needed in order to sort the two columns and then compare the values together.

In the second part I used `Enum.frequencies/1` to compute the occurrences of each number and then simply iterated over them and multiplied them by the count in the other list.

## 2015

### 2015 Day 01

In this puzzle, the first part could be solved by simply getting the number of opening and closing parents and then subtracting them.
For example if you open 3 and close 4 you get `-1`. This was easily accomplished by using `Enum.frequencies/1` which counts the occurrences of the element in an array.

For part two however, the story was different, I did not see a way to do it at a functional "higher order" way. So I resorted to use a "simple" while.
I used `Enum.reduce_while/3` which allows to iterate over a collection while keeping an accumulator and also exit early by returning `{:halt, acc}` instead of `{:cont, acc}`. This was very natural to write.
