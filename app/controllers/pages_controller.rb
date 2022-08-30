class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @missions = Mission.all
    @user = current_user
  end

  def dashboard
  end

  def myprofile
    @user = current_user
  end
end
