class User < ApplicationRecord
  has_many :samplers

  validates_presence_of :display_name, :email, :spotify_id
  validates_uniqueness_of :email, :spotify_id
end