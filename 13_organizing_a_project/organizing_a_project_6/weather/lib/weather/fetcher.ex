defmodule Weather.Fetcher do
  require Logger
  import SweetXml

  @weather_url Application.get_env(:weather, :weather_url)

  @user_agent [{"User-agent", "Elixir christianmsakai@gmail.com"}]

  @doc """
  Fetch weather data in XML format
  """
  def fetch do
    Logger.info "Fetching weather data from #{@weather_url}"

    @weather_url
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    Logger.info "Successful response"
    Logger.debug fn -> inspect(body) end

    {:ok, parse_xml_to_json(body)}
  end

  def handle_response({_, %{status_code: status, body: body}}) do
    Logger.error "Error #{status} returned"

    {:error, body}
  end

  @doc """
  Convert xml into key value dictionary
  """
  def parse_xml_to_json(xml) do
    xml 
    |> xmap(
      location: ~x"//current_observation/location/text()"s,
      station_id: ~x"//current_observation/station_id/text()"s,
      latitude: ~x"//current_observation/latitude/text()"s,
      longitude: ~x"//current_observation/longitude/text()"s,
      observation_time: ~x"//current_observation/observation_time/text()"s,
      weather: ~x"//current_observation/weather/text()"s,
      temperature_string: ~x"//current_observation/temperature_string/text()"s,
      relative_humidity: ~x"//current_observation/relative_humidity/text()"s,
      wind_string: ~x"//current_observation/wind_string/text()"s,
      wind_degrees: ~x"//current_observation/wind_degrees/text()"s,
      pressure_string: ~x"//current_observation/pressure_string/text()"s,
      dewpoint_string: ~x"//current_observation/dewpoint_string/text()"s
    )
  end
end
