class Sampler < ApplicationRecord
  belongs_to :user
  has_many :tracks

  validates_presence_of :user_id, :title
end
