defmodule LookThirteen do
  @moduledoc """
  Look inside a list of words 
  and apply Caesar.rot13 to and look
  if the result is also in the list.

  This module can be improved using
  spawned processes.
  """

  @doc """
  Run this whole module on a file.

  ## Parameters
  - `filename` - the file that contains list of words
  """
  def run(filename) do
    words = 
      filename
      |> File.stream!([:read, :utf8], :line)
      |> Enum.map(fn line -> 
        line
        |> String.strip
        |> String.downcase
      end)

    wordgroup_by_length =
      words
      |> Enum.group_by(&String.length/1)

    wordgroup_by_length |> filter_rot13
  end

  @spec filter_rot13(%{number() => [binary()]}) :: %{number() => [binary()]}
  defp filter_rot13(wordgroups) do
    wordgroups
    |> Enum.reduce(%{}, fn ({size, wordlist}, acc) ->
      wordlist = check_rot13(wordlist)

      if length(wordlist) == 0 do
        acc
      else
        Map.put_new(acc, size, check_rot13(wordlist))
      end
    end)
  end

  @spec check_rot13([binary()]) :: [binary()]
  defp check_rot13(wordlist) do
    wordlist
    |> Enum.filter(fn word ->
      encrypted = Caesar.rot13(word)


      Enum.member?(wordlist, encrypted)
    end)
  end
end
