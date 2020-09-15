# frozen_string_literal: true

require './lib/logging'

class Weather
  include Logging
  def heavy_rains(longitude:, latitude:, spot_name:)
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

      # TODO: test/developmentに関わらず挙動がちゃんとしている dry run的な
      next if rate <= 3

      heavy_rains << {
        rate: rate,
        rains_at: datetime,
        spot_name: spot_name
      }
    end

    heavy_rains
  end
end
