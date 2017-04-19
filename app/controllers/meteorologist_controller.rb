require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address}"
    parsed_data = JSON.parse(open(url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    @latitude = latitude
    @longitude = longitude

    url = "https://api.darksky.net/forecast/b58403e24b518e9db236134f9cab953e/#{@latitude},#{@longitude}"
    parsed_data = JSON.parse(open(url).read)
    current_temperature = parsed_data["currently"]["temperature"]
    current_summary = parsed_data["currently"]["summary"]
    summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]
    summary_of_next_several_hours = parsed_data["hourly"]["summary"]
    summary_of_next_several_days = parsed_data["daily"]["summary"]

    @current_temperature = current_temperature

    @current_summary = current_summary

    @summary_of_next_sixty_minutes = summary_of_next_sixty_minutes

    @summary_of_next_several_hours = summary_of_next_several_hours

    @summary_of_next_several_days = summary_of_next_several_days

    render("meteorologist/street_to_weather.html.erb")
  end
end
