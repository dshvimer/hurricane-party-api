class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :body,
            presence: true

  before_create :set_coords

  reverse_geocoded_by :latitude, :longitude

  def self.close_to(user)
    near([user.latitude, user.longitude])
  end

  private

  def set_coords
    self.latitude = user.latitude
    self.longitude = user.longitude
  end
end
