# frozen_string_literal: true

require 'dotenv'
require 'json'
require 'active_support/all'
require 'open-uri'
require 'net/http'
require 'date'
# ~/.aws/credentials で認証情報を設定している
require 'aws-sdk'
require 'dynamoid'

# TODO: '../lib ' で良い気がするんだけど、なぜか../../と記載しないとできない...なぜだろう
Dir[File.expand_path('../../lib', __FILE__) << '/*.rb'].each do |file|
  require file
end

require './models/spot'

Dotenv.load
