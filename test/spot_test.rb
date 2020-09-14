# frozen_string_literal: true

require 'test-unit'

require './config/libs'
require './lib/spot'

class TestSpot < Test::Unit::TestCase
  def test_all
    assert_equal Array, Spot.all.class
  end
end
