class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :mission

  validates :start_date, :end_date, presence: true
  # enum status: { pending: 0, accepted: 1, declined: 2 }
end
