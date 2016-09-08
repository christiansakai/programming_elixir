defprotocol Caesar do
  @moduledoc """
  Demonstration on using protocol and
  its implementation. This module will
  encrypt data by moving the bits.
  """

  @doc """
  Encrypt a string by shifting its 
  character by a number.
  """
  @callback encrypt(any(), pos_integer()) :: any()
  def encrypt(data, shift)

  @doc """
  Rotate a string by 13 position.
  """
  @callback rot13(any()) :: any()
  def rot13(data)
end

defimpl Caesar, for: List do
  @moduledoc """ 
  Demonstration on implementing a
  protocol. This module will implement
  encryption for charlist.
  """

  @letter_length 26
  @upper_case_start 65
  @upper_case_end 90
  @lower_case_start 97
  @lower_case_end 122

  @doc """
  Encrypt a char list by shifting 
  a certain number.
  """
  @spec encrypt([char()], pos_integer()) :: [char()]
  def encrypt(list, shift) do
    list
    |> Enum.map(&shift_char(&1, shift))
  end

  @doc """
  Encrypt a list by rotating it 13
  point.
  """
  @spec rot13([char()]) :: [char()]
  def rot13(list) do
    encrypt(list, 13)
  end

  defp is_upper_case?(i) do
    i >= @upper_case_start && i <= @upper_case_end
  end

  defp is_lower_case?(i) do
    i >= @lower_case_start && i <= @lower_case_end
  end

  defp rotate(i, shift) do
    rem(i + shift, @letter_length)
  end

  defp shift_char(i, shift) do
    cond do
      is_upper_case?(i) ->
        rotate(i - @upper_case_start, shift) + @upper_case_start
      is_lower_case?(i) ->
        rotate(i - @lower_case_start, shift) + @lower_case_start
      true ->
        i
    end
  end
end

defimpl Caesar, for: BitString do
  @moduledoc """
  Demonstration on implementing a
  protocol. This module will implement
  encryption for charlist.
  """

  @doc """
  Encrypt a string by shifting its 
  character by a number.
  """
  @spec encrypt(binary(), pos_integer()) :: binary()
  def encrypt(string, shift) do
    string
    |> String.to_charlist()
    |> Caesar.encrypt(shift) 
    |> List.to_string()
  end

  @doc """
  Encrypt a string by rotating 
  each character by 13.
  """
  @spec rot13(binary()) :: binary()
  def rot13(string) do
    string
    |> String.to_charlist()
    |> Caesar.rot13()
    |> List.to_string()
  end
end
