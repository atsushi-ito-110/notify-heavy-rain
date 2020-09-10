require 'test-unit'
require 'dotenv'

require './lib/slack'

Dotenv.load

class TestSlack < Test::Unit::TestCase
  def test_last_notify
    slack = Slack.new
    assert_equal true, slack.needs_notify?
  end
end
