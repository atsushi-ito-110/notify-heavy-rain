# frozen_string_literal: true

require './config/libs'

include Logging

def lambda_handler(event:, context:)
  logger.info(event)
  logger.info(context)

  weather = Weather.new
  slack = Slack.new
  Spot.all.each do |spot|
    logger.info(spot)
    # TODO: 最終通知時間などの判定
    unless spot.last_notified_at.empty?
      logger.info('needs_notify? is false')
      next
    end

    heavy_rains = weather.heavy_rains(
      longitude: spot.longitude,
      latitude: spot.latitude,
      spot_name: spot.name,
    )

    if heavy_rains.empty?
      logger.info('heavy_rains is empty')
      next
    end

    unless slack.notify_rains(heavy_rains) == '200'
      logger.error('notify is failed')
    end
  end

end
