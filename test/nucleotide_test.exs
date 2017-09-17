defmodule NucleotideCountTest do
  # These tests are taken from Exercism Elixir track.
  
  use ExUnit.Case
  use EQC.ExUnit

  test "empty dna string has no adenine" do
    assert NucleotideCount.count('', ?A) == 0
  end

  test "repetitive cytosine gets counted" do
    assert NucleotideCount.count('CCCCC', ?C) == 5
  end

  test "counts only thymine" do
    assert NucleotideCount.count('GGGGGTAACCCGG', ?T) == 1
  end

  test "empty dna string has no nucleotides" do
    expected = %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
    assert NucleotideCount.histogram('') == expected
  end

  test "repetitive sequence has only guanine" do
    expected = %{?A => 0, ?T => 0, ?C => 0, ?G => 8}
    assert NucleotideCount.histogram('GGGGGGGG') == expected
  end

  test "counts all nucleotides" do
    s = 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC'
    expected = %{?A => 20, ?T => 21, ?C => 12, ?G => 17}
    assert NucleotideCount.histogram(s) == expected
  end

  property "Sum of counts of each nucleotide should equal the total length of DNA strand" do
    forall clist <- list(oneof([return(?A), return(?C), return(?G), return(?T)])) do
      a_count = NucleotideCount.count(clist, ?A)
      c_count = NucleotideCount.count(clist, ?C)
      g_count = NucleotideCount.count(clist, ?G)
      t_count = NucleotideCount.count(clist, ?T)
      expected_historgram = %{?A => a_count, ?C => c_count, ?G => g_count, ?T => t_count}
      ensure length(clist) == a_count + c_count + g_count + t_count
      ensure NucleotideCount.histogram(clist) == expected_historgram
    end
  end
end
