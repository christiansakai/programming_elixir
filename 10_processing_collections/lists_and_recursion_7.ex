defmodule Primes do
  @moduledoc """
  Module to get the list of primes in a range.
  """

  @doc """
  Get the list of primes in a range.

  ## Parameters

  - `from` - starting point.
  - `to` - ending point.

  ## Examples

      iex> Primes.primes(1, 10)
      [3, 5, 7]
  """
  @spec primes(pos_integer(), pos_integer()) :: [number()]
  def primes(from, to) do
    for x <- from..to, prime?(x) == true, do: x
  end

  @doc """
  Check whether a number is prime or not.

  ## Parameters

  - `x` - the number to be checked.

  ## Examples

      iex> Primes.prime? 2
      false
      iex> Primes.prime? 7
      true
  """
  @spec prime?(pos_integer()) :: boolean()
  def prime?(x) do
    Enum.all?(2..(x - 1), &(rem(x, &1) !== 0))
  end
end
