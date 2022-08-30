class Mission < ApplicationRecord
  validates :title, :description, :address, :price, presence: true
end
