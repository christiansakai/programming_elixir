defmodule MyList do
  def span(from, to) do
    _span(from, to)
  end

  defp _span(from, to) when from > to, do: []

  defp _span(from, to) do
    [from | _span(from + 1, to)]
  end
end

defmodule Primes do
  def prime?(x) do
    Enum.all?(MyList.span(2, x - 1), &(rem(x, &1) !== 0))
  end
end

primes = for x <- MyList.span(1, 10), Primes.prime?(x) do
  x
end

IO.inspect primes
