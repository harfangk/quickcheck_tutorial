defmodule RotationalCipher do
  # This exercise is taken from Exercism Elixir track.

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(&shift_english_alphabets(&1, shift))
    |> List.to_string()
  end

  defp shift_english_alphabets(c, shift) when c in ?A..?Z do
    rem(c - ?A + shift, 26) + ?A
  end
  defp shift_english_alphabets(c, shift) when c in ?a..?z do
    rem(c - ?a + shift, 26) + ?a
  end
  defp shift_english_alphabets(c, _), do: c
end
