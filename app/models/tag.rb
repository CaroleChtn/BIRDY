class Tag < ApplicationRecord
  belongs_to :category

  has_many :mission_tags, dependent: :destroy
end
