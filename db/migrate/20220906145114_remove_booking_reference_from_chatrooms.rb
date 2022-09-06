class RemoveBookingReferenceFromChatrooms < ActiveRecord::Migration[7.0]
  def change
    change_column_null :chatrooms, :booking_id, true
  end
end
