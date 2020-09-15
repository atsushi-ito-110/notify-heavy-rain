# frozen_string_literal: true

require 'logger'

module Logging

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def logger
      Logging.logger
    end
  end

  def logger
    Logging.logger
  end

  def self.logger
    @logger ||= Logger.new($stdout)
  end
end
