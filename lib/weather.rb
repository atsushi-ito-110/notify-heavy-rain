# frozen_string_literal: true

class Weather
  def heavy_rains(longitude = ENV['LONGITUDE'], latitude = ENV['LATITUDE'])
    logger = Logger.new($stdout)
    hash = Hash.from_xml(
      URI.open(
        "https://map.yahooapis.jp/weather/V1/place?coordinates=#{longitude},#{latitude}&appid=#{ENV['YAHOO_API_KEY']}"
      ).read
    )
    json = JSON[hash.to_json, symbolize_names: true]

    weathers = json[:YDF][:Feature][:Property][:WeatherList][:Weather]

    logger.info(json[:YDF][:Feature][:Name])

    heavy_rains = []
    weathers.each do |w|
      logger.info("#{w[:Date]}: #{w[:Rainfall]}")
      rate = w[:Rainfall].to_f
      datetime = Time.parse(w[:Date])

      # TODO: dry run
      next if rate <= 1

      heavy_rains << { rate: rate, rains_at: datetime }
    end

    heavy_rains
  end
end
