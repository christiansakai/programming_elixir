defmodule FizzBuzz do
  @shortdoc """
  Demonstrate a control flow.
  """

  @doc """
  Return list containing "Fizz" or "Buzz"
  or a number.

  ## Parameters

  - `n` - the list will contain up to this number.

  ## Example

      iex> FizzBuzz.upto(20)
      [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14, "FizzBuzz", 16, 17, "Fizz", 19, "Buzz"]
  """
  @spec upto(pos_integer()) :: list()
  def upto(n) when n > 0, do: _upto(1, n, [])
  defp _upto(_current, 0, result), do: Enum.reverse result
  defp _upto(current, left, result) do
    next_answer = 
      case current do
        current when rem(current, 3) == 0 
                and rem(current, 5) == 0 ->
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
