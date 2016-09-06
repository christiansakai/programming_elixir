defmodule MyList do
  @moduledoc """
  Module to demonstrate list operations.
  """

  @doc """
  Flatten a nested list.

  ## Parameters

  - `list` - a nested list to be operated on.

  ## Examples

      iex> MyList.flatten([1, [2, 3, [4]]])
      [1, 2, 3, 4]
  """

  def flatten(list) do
    _flatten(list)
  end

  defp _flatten([]), do: []
  defp _flatten([h | t]) when is_list(h) do
    _flatten(h) ++ flatten(t)
  end
  defp _flatten([h | t]) do
    [h | _flatten(t)]
  end
end
