defmodule FizzBuzz do

  def upto(n) when n > 0, do: _upto(1, n, [])

  defp _upto(_current, 0, result), do: Enum.reverse result

  defp _upto(current, left, result) do
    next_answer = 
      case current do

        current when rem(current, 3) == 0 and rem(current, 5) == 0 ->
          "FizzBuzz"

        current when rem(current, 3) == 0 ->
          "Fizz"

        current when rem(current, 5) == 0 ->
          "Buzz"

        _ ->
          current
      end

    _upto(current + 1, left - 1, [next_answer | result ])
  end

end

IO.inspect FizzBuzz.upto(20)
