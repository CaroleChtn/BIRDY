class Mission < ApplicationRecord
  validates :title, :description, :address, :price, presence: true
  has_many :favorites
  has_many :mission_tags
  has_many :mission_tags, dependent: :destroy

  has_many :bookings
  has_many :chatrooms, through: :bookings

  has_many :tags, through: :mission_tags
  has_many :categories, through: :tags

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
