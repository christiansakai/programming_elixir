defmodule MyList do
  def mapsum(list, func) do
    _mapsum(list, func, 0)
  end

  defp _mapsum([], _func, acc), do: acc

  defp _mapsum([h | t], func, _acc) do
    _mapsum(t, func, func.(h))
  end


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


  def span(from, to) do
    _span(from, to)
  end

  defp _span(from, to) when from > to, do: []

  defp _span(from, to) do
    [from | _span(from + 1, to)]
  end

end

IO.inspect MyList.mapsum([1, 2, 3], &(&1 * &1))
IO.inspect MyList.max([6, 3, 2, 5, 1, 7])
IO.inspect MyList.caesar('ryvkve', 13)
IO.inspect MyList.span(1, 6)
