class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  helper_method :resource_name, :resource, :devise_mapping, :resource_class

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

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
