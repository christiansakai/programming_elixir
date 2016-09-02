defmodule MyEnum do
  
  def all?(list) do
    all?(list, fn x -> !!x end) # !! converts truthy to `true`
  end

  def all?([], _func), do: true

  def all?([h | t], func) do
    if func.(h) do
      all?(t, func)
    else
      false
    end
  end


  def each([], _func), do: []

  def each([h | t], func) do
    [func.(h) | each(t, func)]
  end


  def filter([], _func), do: []

  def filter([h | t], func) do
    if func.(h) do
      [h, filter(t, func)]
    else
      [filter(t, func)]
    end
  end


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


  def take(list, n), do: hd(split(list, n))

end

IO.inspect MyEnum.all?([])                 #=> true
IO.inspect MyEnum.all?([true, true])       #=> true
IO.inspect MyEnum.all?([true, false])      #=> false
IO.inspect MyEnum.all?([4, 5, 6], &(&1 > 3))  #=> true

MyEnum.each([1,2,3], &IO.puts/1)          #=> 1/2/3

IO.inspect MyEnum.split([1,2,3,4,5,6], 3)  #=> [[1, 2, 3], [4, 5, 6]]

IO.inspect MyEnum.take('pragmatic', 6)     #=> 'pragma'

