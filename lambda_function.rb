# frozen_string_literal: true

require 'json'
require 'active_support/all'
require 'open-uri'
require 'logger'
require 'net/http'
require 'date'
require 'dotenv'

def lambda_handler(event:, context:)
  logger = Logger.new(STDOUT)
  Dotenv.load
  longitude = ARGV[0] || ENV['LONGITUDE']
  latitude  = ARGV[1] || ENV['LATITUDE']
  hash = Hash.from_xml(
    URI.open(
      "https://map.yahooapis.jp/weather/V1/place?coordinates=#{longitude},#{latitude}&appid=#{ENV['YAHOO_API_KEY']}"
    ).read
  )
  json = JSON[hash.to_json, symbolize_names: true]

  spot = json[:YDF][:Feature][:Name]
  weathers = json[:YDF][:Feature][:Property][:WeatherList][:Weather]

  logger.info(spot)
  heavy_rains = []
  weathers.each do |w|
    logger.info("#{w[:Date]}: #{w[:Rainfall]}")
    rate = w[:Rainfall].to_f
    datetime = Time.parse(w[:Date])

    next if rate <= 0

    heavy_rains << { rate: rate, datetime: datetime }
  end

  heavy_rains.each do |heavy_rain|
    logger.info(heavy_rain.to_json)
  end

  if heavy_rains.empty?
    logger.info('heavy_rains is empty')
    return
  end

  uri = URI.parse(ENV['SLACK_WEBHOOK_URL'])
  params = {
    channel: '#' + ENV['SLACK_CHANNEL'],
    username: 'rain_cloud',
    text: 'テスト',
    icon_emoji: 'ghost'
  }
  headers = { 'Content-Type' => 'application/json' }
  response = Net::HTTP.post(uri, params.to_json, headers)
  logger.info("code: #{response.code}, body: #{response.body}")
end
