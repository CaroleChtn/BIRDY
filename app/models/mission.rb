class Mission < ApplicationRecord
  validates :title, :description, :address, :price, presence: true

  has_many :mission_tags
  has_many :tags, through: :mission_tags
  has_many :categories, through: :tags
end
