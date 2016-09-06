defmodule Parse do
  @moduledoc """
  A module to demonstrate on parsing string.
  """

  @doc """
  Calculate a mathematical expression.

  ## Parameters

  - `expression` - an expression in char list.

  ## Examples

      iex> Parse.calculate('23+45')
      68
      iex> Parse.calculate('34  - 56')
      -22
      iex> Parse.calculate('12 * 23')
      276
      iex> Parse.calculate('123 / 8')
      15
  """
  @spec calculate(charlist()) :: number()
  def calculate(expression) do
    {number_1, rest} = parse_number(expression)
    rest = skip_spaces(rest)
    {operation, rest} = parse_operator(rest)
    rest = skip_spaces(rest)
    {number_2, []} = parse_number(rest)

    operation.(number_1, number_2)
  end

  defp parse_number(expression), do: _parse_number({0, expression})
  defp _parse_number({value, [digit | rest]}) when digit in ?0..?9 do
    _parse_number({value * 10 + digit - ?0, rest})
  end
  defp _parse_number(result), do: result

  defp skip_spaces([?\s | rest]), do: skip_spaces(rest)
  defp skip_spaces(rest), do: rest

  defp parse_operator([?+ | rest]), do: {&(&1 + &2), rest}
  defp parse_operator([?- | rest]), do: {&(&1 - &2), rest}
  defp parse_operator([?* | rest]), do: {&(&1 * &2), rest}
  defp parse_operator([?/ | rest]), do: {&(div(&1, &2)), rest}
end
