defmodule Times do
  @moduledoc """
  Demonstrate modules and functions.
  """

  @doc """
  Double a value.

  ## Parameters

  - `n` - a number to be doubled.

  ## Examples

      iex> Times.double(2)
      4
  """
  @spec double(number()) :: number()
  def double(n), do: n * 2

  @doc """
  Triple a value.

  ## Parameters

  - `n` - a number to be tripled.

  ## Examples

      iex> Times.triple(2)
      6
  """
  @spec triple(number()) :: number()
  def triple(n), do: n * 3

  @doc """
  Quadruple a value.

  ## Parameters

  - `n` - a number to be quadrupled.

  ## Examples

      iex> Times.quadruple(2)
      16
  """
  @spec quadruple(number()) :: number()
  def quadruple(n), do: double(n) * double(n)
end
