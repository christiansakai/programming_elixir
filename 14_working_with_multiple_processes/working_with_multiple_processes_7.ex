defmodule Parallel do
  @moduledoc """
  Example of how to do concurrent processing.
  """

  @doc """
  Map a list.
  """
  def pmap(collection, fun) do
    me = self

    collection
    |> Enum.map(fn el ->
      spawn_link(fn ->
        send me, {self, fun.(el)}
      end)
    end)
    |> Enum.map(fn pid ->
      receive do
        { ^pid, result } -> result 
      end
    end)
  end
end

IO.inspect Parallel.pmap 1..1000000, &(&1 * &1)

