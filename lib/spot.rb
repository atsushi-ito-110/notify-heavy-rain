# frozen_string_literal: true

require './lib/logging'

class Spot
  include Logging

  def initialize
  end

  def self.all
    resp = client.scan({ table_name: "dev-weather-spot" })
    resp.items
  end

  def self.client
    client = Aws::DynamoDB::Client.new(region: 'ap-northeast-1')
  end

end
