defmodule TableFormatterTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias Weather.TableFormatter, as: TF

  def simple_test_data do
    %{
      location: "Location 1",
      weather: "Weather 1",
      wind_pressure: "Wind Pressure 1",
      longitude: "Longitude 1",
      latitude: "Latitude 1"
    }
  end

  test "calculate widths" do
    result = TF.calculate_widths(simple_test_data)

    assert result === [13, 15]
  end

  test "print header based on data" do
    result = capture_io fn ->
      TF.print_header(simple_test_data)
    end

    assert result === """
     attributes |    values    
    """
  end

  test "print separator based on data" do
    result = capture_io fn ->
      TF.print_separator(simple_test_data)
    end

    assert result === """
    -------------+---------------
    """
  end

  test "print contents based on data" do
    result = capture_io fn ->
      TF.print_contents(simple_test_data)
    end

    assert result === """
      latitude  |  Latitude 1  
      location  |  Location 1  
      longitude  |  Longitude 1  
       weather   |   Weather 1   
    wind_pressure|Wind Pressure 1
    """
  end
end
