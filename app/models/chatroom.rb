class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :booking

  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations, source: :user

  belongs_to :booking, optional: true
end
