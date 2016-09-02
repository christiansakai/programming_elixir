defmodule Weather.CLI do
  @moduledoc """
  Command line to fetch current weather data
  and print it in a nicely format to the console
  """
  def main(_argv) do
    process
  end

  def process do
    Weather.Fetcher.fetch()
    |> decode_response
    |> Weather.TableFormatter.print_table
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    
    IO.puts "Error fetching weather: #{message}"
    System.halt(2)
  end

end
