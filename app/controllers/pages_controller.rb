class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @missions = Mission.all
    @user = current_user
  end

  def dashboard
    @user = current_user
    @missions = @user.missions
    @mission = Mission.new
    @past_bookings = @user.bookings.select {|booking| booking.end_date < Date.today}
    @current_bookings = @user.bookings.select {|booking| booking.start_date == Date.today}
    @future_bookings = @user.bookings.select {|booking| booking.start_date > Date.today}
  end

  def myprofile
    @user = current_user
  end
end
