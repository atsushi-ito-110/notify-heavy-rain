# frozen_string_literal: true

require 'test-unit'

require './config/libs'
require './lib/weather'

Dotenv.load

class TestWeather < Test::Unit::TestCase
  def test_heavy_rains
    w = Weather.new
    assert_equal [], w.heavy_rains
  end
end
