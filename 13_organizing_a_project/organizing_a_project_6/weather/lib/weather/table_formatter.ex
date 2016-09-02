defmodule Weather.TableFormatter do
  @doc """
  Take a raw data in the form of a dictionary with keys
  and values. Print the header, titled "Attributes"
  and "Values", print a separator, and print
  the data in a nicely format
  """
  def print_table(dict) do
    print_header(dict)
    print_separator(dict)
    print_contents(dict)
  end

  def headers do
    [:attributes, "values"]
  end

  @doc """
  Given a key value pairs, print header with tile
  "Attributes" and "Values", padded 
  """
  def print_header(dict) do
    attributes_values = headers
      |> Enum.map(&to_string/1) 

    [attr, val] = dict
    |> calculate_widths
    |> Enum.zip(attributes_values)
    |> Enum.map(fn {max_length, str} ->
      pad = (max_length - String.length(str))
        |> div(2)

      String.duplicate(" ", pad) <> str <> String.duplicate(" ", pad)
    end)

    IO.puts(attr <> "|" <> val)
  end

  @doc """
  Print separator
  """

  def print_separator(dict) do
    [sep_attr, sep_val] = dict
    |> calculate_widths
    |> Enum.map(fn column_length ->
      String.duplicate("-", column_length)
    end)

    IO.puts(sep_attr <> "+" <> sep_val)
  end

  @doc """
  Print contents, which are key value pairs,
  with padding
  """
  def print_contents(dict) do
    [attr_width, val_width] = dict |> calculate_widths

    dict
    |> Enum.map(fn {attr, val} ->
      attr_str = to_string(attr)
      attr_pad = (attr_width - String.length(attr_str))
        |> div(2)

      attr_padded = String.duplicate(" ", attr_pad) <> attr_str <> String.duplicate(" ", attr_pad) 

      val_pad = (val_width - String.length(val))
        |> div(2)

      val_padded = String.duplicate(" ", val_pad) <> val <> String.duplicate(" ", val_pad)

      attr_padded <> "|" <> val_padded
    end)
    |> Enum.each(&IO.puts/1)
  end

  @doc """
  Given a dictionary with key value pairs,
  calculate the maximum width needed for displaying keys
  and the maximum width needed for displaying values

  ## Example
      iex> dict = %{location: "Location 1", weather: "Weather 1", wind_pressure: "Wind Pressure 1", longitude: "Longitude 1", latitude: "Latitude 1"}
      iex> Weather.TableFormatter.calculate_widths(dict)
      [13, 15]
  """
  def calculate_widths(dict) do
    [attributes, values] = headers

    dict_with_headers = dict
      |> Map.put_new(attributes, values)

    longest_key_length = dict_with_headers
      |> Map.keys
      |> Enum.map(&to_string/1)
      |> Enum.max_by(&String.length/1)
      |> String.length

    longest_value_length = dict_with_headers
      |> Map.values
      |> Enum.map(&to_string/1)
      |> Enum.max_by(&String.length/1)
      |> String.length

    [longest_key_length, longest_value_length]
  end
end
