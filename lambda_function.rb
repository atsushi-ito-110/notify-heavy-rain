# frozen_string_literal: true

require 'dotenv'
require 'json'
require 'active_support/all'
require 'open-uri'
require 'net/http'
require 'date'
require 'aws-sdk'

require './lib/weather'
require './lib/slack'
require './lib/logging'

include Logging

def lambda_handler(event:, context:)
  Dotenv.load

  logger.info(event)
  logger.info(context)

  # TODO: 最終通知時間などの判定
  slack = Slack.new
  unless slack.needs_notify?
    logger.info("needs_notify? is false")
    return
  end

  weather = Weather.new
  heavy_rains = weather.heavy_rains

  if heavy_rains.empty?
    logger.info('heavy_rains is empty')
    return
  end

  slack.notify_rains(heavy_rains)
end
