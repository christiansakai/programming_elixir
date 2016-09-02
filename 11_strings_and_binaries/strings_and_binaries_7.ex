defmodule ReadParse do

  def read_file(filename) do
    {:ok, file} = filename
    |> File.open([:read])

    data = file
    |> IO.stream(:line)
    |> Enum.into([])

    process_data(data)
  end

  def process_data([header | contents]) do
    [property_1, property_2, property_3] = String.split(header, ",")
      |> Enum.map(&String.strip/1)

    for content <- contents do
      [value_1, value_2, value_3] = String.split(content, ",")
        |> Enum.map(&String.strip/1)

      [ {String.to_atom(property_1), value_1},
        {String.to_atom(property_2), value_2},
        {String.to_atom(property_3), value_3} ]
    end
  end

end

IO.inspect ReadParse.read_file("sales_tax")
