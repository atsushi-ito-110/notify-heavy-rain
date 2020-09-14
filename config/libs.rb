# frozen_string_literal: true

require 'dotenv'
require 'json'
require 'active_support/all'
require 'open-uri'
require 'net/http'
require 'date'
require 'aws-sdk'

require './lib/weather'
require './lib/slack'
require './lib/spot'
require './lib/logging'

Dotenv.load
