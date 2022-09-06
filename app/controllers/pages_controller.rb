class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @missions = Mission.all
    @user = current_user
  end

  def change_category
    current_user.category = Category.find(params[:change][:category])
    current_user.save

    redirect_to dashboards_path
  end

  def dashboard
    @users = User.all
    @user = current_user
    @missions = @user.missions
    @mission = Mission.new
    @past_bookings = @user.bookings.select {|booking| booking.end_date < Date.today}
    @current_bookings = @user.bookings.select {|booking| booking.start_date == Date.today}
    @future_bookings = @user.bookings.select {|booking| booking.start_date > Date.today}
  end

  def update_profile
    current_user.continent = params[:user][:continent]
    current_user.traveler_style = params[:user][:traveler_style]
    current_user.category = Category.find(params[:user][:category])
    current_user.save!
    # redirect vers les missions filtrées
    redirect_to missions_path(
                                continent: current_user.continent,
                                traveler_style: current_user.traveler_style,
                                category: current_user.category.name
                            )
    flash.notice = "Profil mis à jour !"
  end

  def myprofile
    @user = current_user
  end
end
