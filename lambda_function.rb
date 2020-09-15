# frozen_string_literal: true

require './config/libs'

include Logging

def lambda_handler(event:, context:)
  logger.info(event)
  logger.info(context)

  # TODO: 最終通知時間などの判定
  weather = Weather.new
  slack = Slack.new
  Spot.all.each do |spot|
    logger.info(spot)
    unless spot['last_notified_at'].empty?
      logger.info('needs_notify? is false')
      next
    end

    heavy_rains = weather.heavy_rains(spot['longitude'], spot['latitude'])

    if heavy_rains.empty?
      logger.info('heavy_rains is empty')
      next
    end

    slack.notify_rains(heavy_rains)
  end

end
