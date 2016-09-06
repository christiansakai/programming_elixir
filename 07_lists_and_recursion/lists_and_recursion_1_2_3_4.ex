defmodule MyList do
  @moduledoc """
  Module to demonstrate list operations.
  """

  @doc """
  Map and sum a list.

  ## Parameters

  - `list` - a list to be operated on.
  - `func` - a function to operate on each element in the list.

  ## Examples

      iex> MyList.mapsum([1, 2, 3], &(&1 * &1))
      9
  """
  @spec mapsum(list(), (number() -> any())) :: number()
  def mapsum(list, func) do
    _mapsum(list, func, 0)
  end
  defp _mapsum([], _func, acc), do: acc
  defp _mapsum([h | t], func, _acc) do
    _mapsum(t, func, func.(h))
  end

  @doc """
  Find max value in a list.

  ## Parameters

  - `list` - a list to be operated on.

  ## Examples

      iex> MyList.max([1, 2, 3])
      3
  """
  @spec max(list()) :: number()
  def max(list) do
    _max(list, 0)
  end
  defp _max([], max), do: max
  defp _max([h | t], max) when h > max do
    _max(t, h)
  end
  defp _max([_h | t], max) do
    _max(t, max)
  end

  @doc """
  Do a caesar cipher.

  ## Parameters

  - `list` - a list of characters.
  - `n` - the cipher secret.

  ## Examples

      iex> MyList.caesar('ryvkve', 13)
      'elixir'
  """
  @spec caesar(list(), number()) :: list()
  def caesar(list, n) do
    _caesar(list, n)
  end
  defp _caesar([], _n), do: []
  defp _caesar([h | t], n) when h + n <= ?z do
    [h + n | _caesar(t, n)]
  end
  defp _caesar([h | t], n) do
    [h + n - 26 | _caesar(t, n)]
  end

  @doc """
  Create a list of numbers.

  ## Parameters

  - `from` - starting point.
  - `to` - ending point.

  ## Examples

      iex> MyList.span(1, 5)
      [1, 2, 3, 4, 5]
  """
  @spec span(number(), number()) :: list()
  def span(from, to) do
    _span(from, to)
  end
  defp _span(from, to) when from > to, do: []
  defp _span(from, to) do
    [from | _span(from + 1, to)]
  end
end
