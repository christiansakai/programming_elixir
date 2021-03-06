defmodule Chop do
  @moduledoc """
  Guess a number.
  """

  @doc """
  Guess a number.

  ## Parameters

  - `actual` - the number to be guessed.
  - `range` - the range to be guessed from.
  """
  @spec guess(pos_integer(), pos_number()..pos_number()) :: :ok
  def guess(actual, range = low..high) do
    guess = div(low + high, 2)
    IO.puts "Is it #{guess}?"

    _guess(actual, guess, range)
  end

  defp _guess(actual, guess, _) when actual === guess do
    IO.puts "Yes, it's #{actual}"
  end

  defp _guess(actual, guess, _low..high) when guess < actual do
    guess(actual, (guess + 1)..high)
  end

  defp _guess(actual, guess, low.._high) when guess > actual do 
    guess(actual, low..(guess - 1))
  end
end
