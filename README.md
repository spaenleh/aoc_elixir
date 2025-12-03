# Advent of code in Elixir

This is my solutions for advent of code in Elixir

I have started this repo to write my solutions in elixir.

This year (2025) I will attempt to solve the puzzles in Elixir.

## 2025

### 2025 Day 01

For the first puzzle this year, it looked simple enough. But there were some hurdles on the way.

First hurdle is the behaviour of the `rem/2` function. It returns a negative result when provided a negative input. So the remainder of -125 over 100 is -25
which is correct but not always what you want. Instead I used `Integer.mod/2` which return `75` for the same `-125 mod 100` computation.

This was enough to solve part 1.

Then began the fun of part 2 or, should I say the dread ... In this part we need to count how many times it "clicks" on zero, meaning if it passes zero but does not stop there it also counts.
For this I divided the work into checking if:

- it lands on zero by being a complement to the number
- it passes zero in one direction or the other
- count how many times it can pass zero given that it makes full turns

The issue is that we need to account for the specific cases where it starts at zero and makes exactly N full turns, where we need to remove one from the turns because it will already be accounted in the complement computation.

### 2025 Day 02

This is where ranges came at us again.
In this puzzle we need to find numbers that are of the pattern `blockblock` where they repeat the same numbers twice.

For this to happen:

- number must have an even number of chars, odd number of chars can not be symmetrical
- take first half of the number and check if it matches second half

What could also work is to check the divisibility by `10^n + 1` where the digit has length 2n.

But before doing a bunch of computations we need to ensure that we are able to reduce the problem space.

We can do two things:

- de-duplicate the ranges so we do not compute the same things multiple times
- remove ranges that have strictly odd length numbers

Before doing this optimization: 1.83s for part 1

### 2025 Day 03

Haha, this is a classic !
In this puzzle we need to find a 2-digit value from a longer sting that maximizes the value.
Very simple at first, let me just get all the ordered pairs for the input string an find the highest one !
Indeed that works.

If you have `[1, 4, 5]` you would generate `[[1, 4], [1, 5], [4, 5]]` and then get `45` as the highest value.

On my machine, on the input given this runs in about 200ms (not too shaby!).

But then... Oh my, part 2 asks to find the 12-digit value that maximizes the joltage ... And you just think "I am sooo f?!\*ed".

This is where good friends come in.
This solution has been proposed by my lovely girlfriend, props to her.

So what you do is you take your long digit array. For the first digit you search through the 0..-2 range of you digits:
`[1, 2, 3, 4]` -> search through `[1, 2, 3]`
Get the highest one. In this case it is `3`. Keep the index it came from, as this will now reduce your search range.
Start again, this time, start after the last index (`2+1` -> `3`) and go up to the end (actually it should be `total_digits - step - 1` -> 0 in our case)
We take the max, in our case only one choice: `4` and we end up with `34` as the result.

Other examples:

- `88395361` -> `96`

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
