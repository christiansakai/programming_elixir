defmodule ListAndRecursion do
  @moduledoc """
  Module to demonstrate list and recursion.
  """

  @doc """
  Calculate the sum of numbers in a list.

  ## Parameters

  - `list` - a list to be operated on.

  ## Examples

      iex> ListAndRecursion.sum([1, 2, 3])
      6
  """
  @spec sum(list()) :: number()
  def sum([]) do
    0
  end
  def sum([h | t]) do
    h + sum(t)
  end
end
