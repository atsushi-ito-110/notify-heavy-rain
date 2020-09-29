# frozen_string_literal: true

require './config/libs'
require './models/spot'

require './lib/logging'

include Logging

if Spot.find_by_name('三ノ輪駅付近').nil?
  spot = Spot.create(
    name: '三ノ輪駅付近',
    latitude: '35.729042',
    longitude: '139.787',
    last_notified_at: ''
  )
  logger.info("created: #{spot.name}")
end

if Spot.find_by_name('南花畑公園付近').nil?
  spot = Spot.create(
    name: '南花畑公園付近',
    latitude: '35.729042',
    longitude: '139.787',
    last_notified_at: ''
  )
  logger.info("created: #{spot.name}")
end
