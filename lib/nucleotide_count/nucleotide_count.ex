defmodule NucleotideCount do
  # This exercise is taken from Exercism Elixir track.
  
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    strand
    |> Enum.filter(&(&1 == nucleotide))
    |> Enum.count()
  end

  @spec histogram([char]) :: map
  def histogram(strand) do
    histogram_map = Enum.into(@nucleotides, %{}, fn x -> {x, 0} end)
    strand
    |> Enum.reduce(histogram_map,
                   fn (x, acc) ->
                     Map.update(acc, x, 1, &(&1 + 1))
                   end)
  end
end
