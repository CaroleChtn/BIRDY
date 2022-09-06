class Category < ApplicationRecord
  has_many :tags, dependent: :destroy
  has_many :users

  def display_name
    case name
    when "poussin" then "Poussin Baroudeur"
    when "hibou" then "Hibou Curieux"
    when "toucan" then "Toucan Nomade"
    when "aigle" then "Super Aigle"
    else
      ""
    end
  end
end
