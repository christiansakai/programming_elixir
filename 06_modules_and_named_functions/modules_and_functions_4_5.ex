defmodule Recursive do
  @moduledoc """
  Demonstrate modules and functions
  and recursive technique.
  """

  @doc """
  Get the sum of a value from 
  an integer to n.

  ## Parameters

  - `n` - the n to be calculated to.

  ## Examples
  
      iex> Recursive.sum(3)
      6
  """
  @spec sum(number()) :: number()
  def sum(0), do: 0
  def sum(n), do: n + sum(n - 1)

  @doc """
  Get the gcd between two values.

  ## Parameters

  - `x` - first number to be calculated.
  - `y` - second number to be calculated.

  ## Examples
  
      iex> Recursive.gcd(20, 15)
      5
  """
  @spec gcd(number(), number()) :: number()
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end
