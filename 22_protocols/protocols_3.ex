defmodule MyEnum do
  @moduledoc """
  Demonstrate that each, filter
  and map can be build
  using reduce alone.
  """

  import Enum, only: [reduce: 3]

  @doc """
  Iterate over enumerable and
  apply the function to each of its elements.
  """

  @spec each(list(), (any() -> any())) :: :ok
  def each(enumerable, fun) do
    reduce(enumerable, :ok, fn x, acc ->
      fun.(x)
    end)
  end

  @doc """
  Iterate over enumerable and
  filter according to the function.
  """

  @spec filter(list(), (any() -> any())) :: list()
  def filter(enumerable, fun) do
    reduce(enumerable, [], fn (x, acc) ->
      if fun.(x) do
        acc ++ [x]
      else
        acc
      end
    end)
  end

  @doc """
  Iterate over enumerable and apply
  change to each of its elements.
  """
  
  @map (list(), (any() -> any())) :: list()
  def map(enumerable, fun) do
    reduce(enumerable, [], fn x, acc ->
      acc ++ [fun.(x)]
    end)
  end
end
