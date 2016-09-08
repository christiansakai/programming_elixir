defmodule MySigil do
  @moduledoc """
  Module to demonstrate
  creating custom sigil.
  """

  def sigil_v(lines, opts) do
    case opts do
      'p' ->
        transform_with_float(lines)
      't' ->
        transform_to_table(lines)
      _ ->
        transform(lines)
    end
  end

  def transform(lines) do
    lines
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
  end

  def transform_with_float(lines) do
    lines
    |> transform
    |> Enum.map(fn list ->
      Enum.map(list, fn word ->
        case Float.parse(word) do
          :error -> 
            word
          {number, _} ->
            number
        end
      end)
    end)
  end

  def transform_to_table(lines) do
    [headers | contents] = 
      lines 
      |> String.trim
      |> String.split("\n")

    [h1, h2, h3] = String.split(headers, ",")

    contents
    |> Enum.map(fn content ->
      [c1, c2, c3] = String.split(content, ",")
      [{:"#{h1}", c1},
       {:"#{h2}", c2},
       {:"#{h3}", c3}]
    end)
  end
end
