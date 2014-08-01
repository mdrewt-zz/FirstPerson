class UsersController < ApplicationController
  include UsersHelper
  include BuildHashHelper

  #User Info

  def profile
    @users = User.all
    @rewards = @user.rewards
  end

  def xp
    @quests = Quest.user_completed_quests(current_user)
    @checkins = current_user.check_ins
    render partial: "users/xp"
  end

  # def class_user
  # end

  def notifications
    if logged_in?
      notice = @user.notifications.map {|notice| notice.to_js}
      @user.notifications.clear
      render json: notice
    else
      render json: []
    end
  end

  # def stats
  # end

  def boards
    @users = User.all
    render layout: false
  end

  # Session Methods

  def index
    if logged_in?
      render 'maps/show'
    else
      render 'users/home'
    end
  end

  def test_login
    session[:user_id] = 1 # artificial login for testing purposes
    redirect_to root_path
  end

  def logout
    session.clear
    redirect_to root_path
  end

  def user_all_checkins_loc
    current_user
    checkins = build_markers(@user.check_ins, "checkin")
    render json: checkins
  end

  def checkin_points
    checkins = build_markers(CheckIn.all, "checkin")
    render json: checkins
  end

  def expbar
    render json: {exp:(current_user.total_xp % 1000)}
  end

end
