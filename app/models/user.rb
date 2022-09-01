class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :favorites
  has_many :bookings
  has_many :missions, through: :bookings
  has_many :favorite_missions, through: :favorites, source: :mission
  # validates :name, :phone_number, presence: true
end
