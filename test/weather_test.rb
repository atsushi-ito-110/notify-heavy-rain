require 'test-unit'
require 'dotenv'

require './lib/weather'

Dotenv.load

class TestWeather < Test::Unit::TestCase
  def test_heavy_rains
    w = Weather.new
    assert_equal [], w.heavy_rains
  end
end
