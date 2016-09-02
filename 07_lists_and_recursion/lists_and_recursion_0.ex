defmodule ListAndRecursion do
  def sum([]) do
    0
  end

  def sum([h | t]) do
    h + sum(t)
  end
end

IO.inspect ListAndRecursion.sum([1, 2, 3])
