# frozen_string_literal: true

require 'json'
require 'active_support/all'
require 'open-uri'
require 'logger'
require 'net/http'
require 'date'
require 'dotenv'

require './lib/weather'
require './lib/slack'

def lambda_handler(event:, context:)
  logger = Logger.new($stdout)
  Dotenv.load

  logger.info(event)
  logger.info(context)

  weather = Weather.new
  heavy_rains = weather.heavy_rains

  if heavy_rains.empty?
    logger.info('heavy_rains is empty')
    return
  end

  Slack.notify_rains(heavy_rains)
end
