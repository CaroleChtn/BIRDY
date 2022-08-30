class Review < ApplicationRecord
  belongs_to :booking
  validates :content, length: {minimum: 20}
end
