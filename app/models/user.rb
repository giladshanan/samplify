class User < ApplicationRecord
  has_many :samplers

  validates_presence_of :email, :spotify_id
  validates_uniqueness_of :email, :spotify_id
  validate :name_check
  validate :image_check
end

def name_check
  self.display_name = self.email if self.display_name.nil?
end

def image_check
  self.profile_pic_url = "cd.png" if self.profile_pic_url.nil?
end
