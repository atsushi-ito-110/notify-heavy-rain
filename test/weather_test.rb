# frozen_string_literal: true

require 'test-unit'

require './config/libs'
require './lib/weather'
require './models/spot'

class TestWeather < Test::Unit::TestCase
  def test_heavy_rains
    s = Spot.all.first.attributes
    w = Weather.new
    assert_equal Array, w.heavy_rains(s[:longitude], s[:latitude], s[:name]).class
  end
end
