defmodule QuickcheckTutorialQuixirTest do
  import Quicksort, only: [quicksort_naive: 1, quicksort_random: 1, quicksort_median: 1, quicksort_dual_pivot: 1]

  use ExUnit.Case
  use Quixir

  test "Naive quicksort is idempotent" do
    ptest [list: list(of: int())] do
      assert quicksort_naive(list) == list |> quicksort_naive() |> quicksort_naive()
    end
  end

  test "Random quicksort is idempotent" do
    ptest [list: list(of: int())] do
      assert quicksort_random(list) == list |> quicksort_random() |> quicksort_random()
    end
  end

  test "Median quicksort is idempotent" do
    ptest [list: list(of: int())] do
      assert quicksort_median(list) == list |> quicksort_median() |> quicksort_median()
    end
  end

  test "Dual pivot quicksort is idempotent" do
    ptest [list: list(of: int())] do
      assert quicksort_dual_pivot(list) == list |> quicksort_dual_pivot() |> quicksort_dual_pivot()
    end
  end

  test "Base64 decode is inverse of decode" do
    ptest [str: string()] do
      :base64.decode(:base64.encode(str)) == str
    end
  end
  
  test "All quicksort implementations are equivalent" do
    ptest [list: list(of: int())] do
      assert quicksort_dual_pivot(list) == quicksort_naive(list)
      assert quicksort_naive(list) == quicksort_median(list)
      assert quicksort_median(list) == quicksort_random(list)
      assert quicksort_dual_pivot(list) == quicksort_random(list)
    end
  end

  test "Addition of two natural numbers should be greater than or equal to either" do
    ptest [n: int(min: 0), m: int(min: 0)] do
      assert (n + m) >= n
      assert (n + m) >= m
    end
  end

#  test "String.reverse is inverse of reverse" do
#    ptest [str: string()] do
#      new_str = str |> String.reverse() |> String.reverse()
#      assert new_str == str
#    end
#  end
end
