# frozen_string_literal: true

require './lib/logging'

class Spot
  include Logging

  attr_accessor :id, :name, :latitude, :longitude, :last_notified_at

  def initialize(item=nil)
    # dynamodbからhashで返ってくるためインスタンス変数にぶちこむ
    item&.map do |key, value|
      instance_variable_set("@#{key.to_s}", value)
    end
  end

  def self.all
    spots = []
    resp = client.scan({ table_name: ENV['WEATHER_SPOT_TABLE_NAME'] })
    resp.items.map do |item|
      Spot.new(item)
    end
  end

  def self.client
    client = Aws::DynamoDB::Client.new(region: 'ap-northeast-1')
  end

end
