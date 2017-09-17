defmodule Quicksort do
  @moduledoc false

  def quicksort_naive([]), do: []
  def quicksort_naive([pivot|t]) do
    quicksort_naive(for x <- t, x < pivot, do: x)
    ++ [pivot] ++
    quicksort_naive(for x <- t, x >= pivot, do: x)
  end

  def quicksort_random([]), do: []
  def quicksort_random(list) do
    list
    |> List.pop_at(random_position_in(list))
    |> _quicksort_random()
  end

  defp _quicksort_random({nil, _}), do: []
  defp _quicksort_random({pivot, []}), do: [pivot]
  defp _quicksort_random({pivot, sublist}) do
    smaller_elements = for x <- sublist, x < pivot, do: x
    larget_elements = for x <- sublist, x >= pivot, do: x
    _quicksort_random(List.pop_at(smaller_elements,
                                  random_position_in(smaller_elements)
                                  ))
    ++ [pivot] ++
    _quicksort_random(List.pop_at(larget_elements,
                                  random_position_in(larget_elements))
                                  )
  end

  defp random_position_in(list) when length(list) > 1, do: :rand.uniform(length(list)) - 1
  defp random_position_in(_), do: 0

  def quicksort_median([]), do: []
  def quicksort_median(list) do
    list
    |> List.pop_at(index_of_median_of_three_random_elements_from(list))
    |> _quicksort_median()
  end

  defp _quicksort_median({nil, _}), do: []
  defp _quicksort_median({pivot, []}), do: [pivot]
  defp _quicksort_median({pivot, sublist}) do
    smaller_elements = for x <- sublist, x < pivot, do: x
    larget_elements = for x <- sublist, x >= pivot, do: x
    _quicksort_median(List.pop_at(smaller_elements,
                                  index_of_median_of_three_random_elements_from(smaller_elements)))
    ++ [pivot] ++
    _quicksort_median(List.pop_at(larget_elements,
                                  index_of_median_of_three_random_elements_from(larget_elements)))
  end

  defp index_of_median_of_three_random_elements_from(list) when length(list) < 3, do: 0
  defp index_of_median_of_three_random_elements_from(list) do
    median =
      list
      |> Enum.take_random(3)
      |> median_of_three_item_list()
    Enum.find_index(list, fn(x) -> x == median end)
  end

  defp median_of_three_item_list(list) do
    case length list do
      3 -> list |> Enum.sort() |> Enum.at(1)
      _ -> nil
    end
  end

  def quicksort_dual_pivot([]), do: []
  def quicksort_dual_pivot([h]), do: [h]
  def quicksort_dual_pivot([h, t]) do
    case h < t do
      true -> [h, t]
      false -> [t, h]
    end
  end

  def quicksort_dual_pivot(list) do
    {first_pivot, temp_sublist} = List.pop_at(list,
     random_position_in(list))
    {second_pivot, target_sublist} = List.pop_at(temp_sublist,
     random_position_in(temp_sublist))

    smaller_pivot = Enum.min([first_pivot, second_pivot])
    larger_pivot = Enum.max([first_pivot, second_pivot])

    quicksort_dual_pivot(for x <- target_sublist, x < smaller_pivot, do: x)
    ++ [smaller_pivot] ++
    quicksort_dual_pivot(for x <- target_sublist, x >= smaller_pivot, x < larger_pivot, do: x)
    ++ [larger_pivot] ++
    quicksort_dual_pivot(for x <- target_sublist, x >= larger_pivot, do: x)
  end
end
