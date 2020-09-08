# frozen_string_literal: true

class Slack
  def self.notify_rains(heavy_rains)
    logger = Logger.new(STDOUT)
    uri = URI.parse(ENV['SLACK_WEBHOOK_URL'])
    heavy_rain = heavy_rains.first
    message = "#{heavy_rain[:rains_at].strftime('%Y-%m-%d %H:%M')}から雨が降るかも！\n降水量: #{heavy_rain[:rate]}"
    params = {
      channel: '#' + ENV['SLACK_CHANNEL'],
      username: '雨通知Bot',
      text: message,
      icon_emoji: 'rain_cloud'
    }
    headers = { 'Content-Type' => 'application/json' }
    response = Net::HTTP.post(uri, params.to_json, headers)
    logger.info("code: #{response.code}, body: #{response.body}")
  end
end
