class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :mission
  has_many :chatrooms

  has_many :reviews, dependent: :destroy

  validates :start_date, :end_date, presence: true
  # enum status: { pending: 0, accepted: 1, declined: 2 }
end
