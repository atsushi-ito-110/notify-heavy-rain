# frozen_string_literal: true

require './lib/logging'

class Slack
  include Logging

  attr_accessor :last_notified_at

  def initialize
    @last_notified_at = Time.now
  end

  def needs_notify?
    logger.info(self.last_notified_at)
    true
  end

  def notify_rains(heavy_rains)
    uri = URI.parse(ENV['SLACK_WEBHOOK_URL'])
    heavy_rain = heavy_rains.first
    message = "#{heavy_rain[:rains_at].strftime('%H:%M')}から雨が降るかも！\n降水量: #{heavy_rain[:rate]}"
    logger.info(message)
    params = {
      channel: "##{ENV['SLACK_CHANNEL']}",
      username: '雨通知Bot',
      text: message,
      icon_emoji: 'rain_cloud'
    }
    headers = { 'Content-Type' => 'application/json' }
    response = Net::HTTP.post(uri, params.to_json, headers)
    logger.info("code: #{response.code}, body: #{response.body}")
    response.code
  end
end
