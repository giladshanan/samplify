class Track < ApplicationRecord
  belongs_to :sampler

  validates_presence_of :url, :name, :sampler_id
end