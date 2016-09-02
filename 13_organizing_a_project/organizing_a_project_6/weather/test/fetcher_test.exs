defmodule FetcherTest do
  use ExUnit.Case

  alias Weather.Fetcher

  def simple_test_data do
    """
    <?xml version="1.0" encoding="ISO-8859-1"?>
    <?xml-stylesheet href="latest_ob.xsl" type="text/xsl"?>
    <current_observation version="1.0"
       xmlns:xsd="http://www.w3.org/2001/XMLSchema"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:noNamespaceSchemaLocation="http://www.weather.gov/view/current_observation.xsd">
        <credit>NOAA's National Weather Service</credit>
        <credit_URL>http://weather.gov/</credit_URL>
        <image>
            <url>http://weather.gov/images/xml_logo.gif</url>
            <title>NOAA's National Weather Service</title>
            <link>http://weather.gov</link>
        </image>
        <suggested_pickup>15 minutes after the hour</suggested_pickup>
        <suggested_pickup_period>60</suggested_pickup_period>
        <location>Denton Municipal Airport, TX</location>
        <station_id>KDTO</station_id>
        <latitude>33.20505</latitude>
        <longitude>-97.20061</longitude>
        <observation_time>Last Updated on May 14 2016, 10:53 pm CDT</observation_time>
        <observation_time_rfc822>Sat, 14 May 2016 22:53:00 -0500</observation_time_rfc822>
        <weather>Fair</weather>
        <temperature_string>59.0 F (15.0 C)</temperature_string>
        <temp_f>59.0</temp_f>
        <temp_c>15.0</temp_c>
        <relative_humidity>64</relative_humidity>
        <wind_string>Northeast at 8.1 MPH (7 KT)</wind_string>
        <wind_dir>Northeast</wind_dir>
        <wind_degrees>50</wind_degrees>
        <wind_mph>8.1</wind_mph>
        <wind_kt>7</wind_kt>
        <pressure_string>1020.6 mb</pressure_string>
        <pressure_mb>1020.6</pressure_mb>
        <pressure_in>30.15</pressure_in>
        <dewpoint_string>46.9 F (8.3 C)</dewpoint_string>
        <dewpoint_f>46.9</dewpoint_f>
        <dewpoint_c>8.3</dewpoint_c>
        <windchill_string>58 F (14 C)</windchill_string>
        <windchill_f>58</windchill_f>
        <windchill_c>14</windchill_c>
        <visibility_mi>10.00</visibility_mi>
        <icon_url_base>http://forecast.weather.gov/images/wtf/small/</icon_url_base>
        <two_day_history_url>http://www.weather.gov/data/obhistory/KDTO.html</two_day_history_url>
        <icon_url_name>nskc.png</icon_url_name>
        <ob_url>http://www.weather.gov/data/METAR/KDTO.1.txt</ob_url>
        <disclaimer_url>http://weather.gov/disclaimer.html</disclaimer_url>
        <copyright_url>http://weather.gov/disclaimer.html</copyright_url>
        <privacy_policy_url>http://weather.gov/notice.html</privacy_policy_url>
    </current_observation>
    """
  end

  test "parse xml to JSON" do
    xml = simple_test_data
    expected = %{
      location: "Denton Municipal Airport, TX",
      station_id: "KDTO",
      latitude: "33.20505",
      longitude: "-97.20061",
      observation_time: "Last Updated on May 14 2016, 10:53 pm CDT",
      weather: "Fair",
      temperature_string: "59.0 F (15.0 C)",
      relative_humidity: "64",
      wind_string: "Northeast at 8.1 MPH (7 KT)",
      wind_degrees: "50",
      pressure_string: "1020.6 mb",
      dewpoint_string: "46.9 F (8.3 C)"
    }

    assert expected === Fetcher.parse_xml_to_json(xml)
  end

  
end
