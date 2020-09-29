# frozen_string_literal: true

require 'test-unit'

require './config/libs'
require './models/spot'

Dynamoid.logger.level = Logger::FATAL

class TestSpot < Test::Unit::TestCase
  include Logging

  def test_save_false_with_name_blank
    spot = Spot.new
    spot.name = ''
    assert_equal false, spot.save
  end

  def test_test
    spots = Spot.all
    assert_equal Integer, spots.count.class
  end

end
