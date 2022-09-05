class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :favorites
  has_many :bookings
  has_many :missions, through: :bookings
  has_many :favorite_missions, through: :favorites, source: :mission

  belongs_to :category, optional: true
  # validates :name, :phone_number, presence: true
  enum continent: { tout: 0, afrique: 1, amérique: 2, asie: 3, europe: 4, océanie: 5 }
  enum traveler_style: { indef: 0, solo: 1, duo: 2, famille: 3 }
end
