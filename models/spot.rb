# frozen_string_literal: true

class Spot
  include Dynamoid::Document
  include Logging

  table name: :spots, key: :spot_id, read_capacity: 5, write_capacity: 5
  field :name, :string
  field :latitude, :string
  field :longitude, :string
  # field :last_notified_at, :datetime

  global_secondary_index hash_key: :name

  validates_presence_of :name
end
