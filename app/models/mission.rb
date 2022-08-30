class Mission < ApplicationRecord
  validates :title, :description, :address, :price, presence: true

  has_many :mission_tags
end
