defmodule MyEnum do
  @moduledoc """
  Module to demonstrate Enum operations in
  a collection.
  """

  @doc """
  Check whether all elements satisified
  the required check or not.

  ## Examples

      iex> MyEnum.all?([4, 5, 6], &(&1 > 3))
      true
  """
  @spec all?([number()]) :: boolean()
  def all?(list) do
    all?(list, fn x -> !!x end) # !! converts truthy to `true`
  end
  def all?([], _func), do: true

  @spec all?(list(), (number() -> boolean())) :: boolean()
  def all?([h | t], func) do
    if func.(h) do
      all?(t, func)
    else
      false
    end
  end
 
  @doc """
  Iterate over each element and run
  the assigned function for each element.
  """
  @spec each([number()], (number() -> any())) :: :ok
  def each([], _func), do: []
  def each([h | t], func) do
    [func.(h) | each(t, func)]
  end

  @doc """
  check whether all elements satisified
  the required check or not.

  ## examples

      iex> MyEnum.filter([1, 6, 4], &(&1 > 3))
      [6, 4]
  """
  @spec filter([number()], (number() -> boolean())) :: [number()]
  def filter([], _func), do: []

  def filter([h | t], func) do
    if func.(h) do
      [h | filter(t, func)]
    else
      filter(t, func)
    end
  end

  @doc """
  Split the list into two list.

  ## Examples

      iex> MyEnum.split([1, 2, 3, 4, 5, 6], 3)
      [[1, 2, 3], [4, 5, 6]]
  """
  @spec split([number()], number()) :: list()
  def split(list, count) do
    _split(list, [], count)
  end

  defp _split([], front, _) do
    [Enum.reverse(front), []]
  end
  defp _split(tail, front, 0) do
    [Enum.reverse(front), tail]
  end
  defp _split([h | t], front, count) do
    _split(t, [h | front], count - 1)
  end

  @doc """
  Take a sublist from a list.

  ## Examples

      iex> MyEnum.take('pragmatic', 6)
      'pragma'
  """
  @spec all?(list(), number()) :: list()
  def take(list, n), do: hd(split(list, n))
end
