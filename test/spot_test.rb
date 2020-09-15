# frozen_string_literal: true

require 'test-unit'

require './config/libs'
require './lib/spot'

class TestSpot < Test::Unit::TestCase
  include Logging
  def test_all
    logger.info(Spot.all)
    assert_equal Array, Spot.all.class
  end
end
