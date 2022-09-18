class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :favorites
  has_many :bookings
  has_many :owned_missions, class_name: 'Mission', foreign_key: :user_id
  has_many :missions, through: :bookings
  has_many :favorite_missions, through: :favorites, source: :mission
  has_many :participations, dependent: :destroy
  has_many :chatrooms, through: :participations

  belongs_to :category, optional: true
  validates :name, presence: true
  # validates :name, :phone_number, presence: true
  enum continent: { tout: 0, afrique: 1, amérique: 2, asie: 3, europe: 4, océanie: 5 }
  enum traveler_style: { indef: 0, solo: 1, duo: 2, famille: 3 }

  def chats_with(user)
    raise
  end

  def chatroom_with(user)
    chatrooms.joins(:participations).where(participations: { user_id: user.id })
  end

  def has_favorites?
    favorites.any?
  end
end
