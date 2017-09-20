defmodule QuickcheckTutorialTest do
  import Quicksort, only: [quicksort_naive: 1, quicksort_random: 1, quicksort_median: 1, quicksort_dual_pivot: 1]

  use ExUnit.Case
  use EQC.ExUnit

  doctest QuickcheckTutorial
  property "Naive quicksort is idempotent" do
    forall list <- list(int()) do
      ensure quicksort_naive(list) == list |> quicksort_naive() |> quicksort_naive()
    end
  end

  property "Random quicksort is idempotent" do
    forall list <- list(int()) do
      ensure quicksort_random(list) == list |> quicksort_random() |> quicksort_random()
    end
  end

  property "Median quicksort is idempotent" do
    forall list <- list(int()) do
      ensure quicksort_median(list) == list |> quicksort_median() |> quicksort_median()
    end
  end

  property "Dual pivot quicksort is idempotent" do
    forall list <- list(int()) do
      ensure quicksort_dual_pivot(list) == list |> quicksort_dual_pivot() |> quicksort_dual_pivot()
    end
  end

  property "Base64 decode is inverse of decode" do
    forall str <- binary() do
      :base64.decode(:base64.encode(str)) == str
    end
  end
  
  property "All quicksort implementations are equivalent" do
    forall list <- list(int()) do
      ensure quicksort_dual_pivot(list) == quicksort_naive(list)
      ensure quicksort_naive(list) == quicksort_median(list)
      ensure quicksort_median(list) == quicksort_random(list)
      ensure quicksort_dual_pivot(list) == quicksort_random(list)
    end
  end

  property "Addition of two natural numbers should be greater than or equal to either" do
    forall {n, m} <- {nat(), nat()} do
      ensure (n + m) >= n 
      ensure (n + m) >= m
    end
  end

  property "Empty list has length of 0" do
    forall l <- (such_that l <- list(int()), do: l == []) do
      ensure length(l) == 0
    end
  end

  property "String.reverse is inverse of reverse" do
    forall str <- utf8() do
      ensure str == str |> String.reverse() |> String.reverse()
    end
  end

  # Exercise 1: For any integer x, square of x should be larger than x
  # Use: int/0, :math.pow/2
  
  # Exercise 2: For any string s, encoding s to base64 and then decoding
  # the base64-encoded string to plain string should yield s
  # Use: utf8/0, :base64.encode/1, :base64.decode/1
  
  # Exercise 3: For any integer list l,
  # and for any function f that takes an integer as argument,
  # the result of mapping f over l should have same length as l
  # Use: list/1, int/0, function1/1, Enum.map/2, length/1
end
