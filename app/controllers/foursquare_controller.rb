class FoursquareController < ActionController::Base

  layout "application"
  include AuthHelper
  include PushHelper
  include UsersHelper

  def index
    redirect_to auth_uri
  end

  def redirect
    token = token_receipt
    @api = Fsqr.new(token.token)
    user = User.find_by(foursquare_id: @api.client.user("self")[:id].to_i)
    if user
      session[:user_id] = user.id
    else
      @user = User.new
      user_creator
      @user.save
      session[:user_id] = @user.id
    end
    redirect_to root_path
  end

  def map

  end

  def pull
    parsed_params = parse_foursquare_json(format(params))

    loc = location_creator(parsed_params)
    loc.save
    checkin = checkin_creator(loc, parsed_params)
    checkin.save
    render plain: "200 OK"
  end

  def push
  	render json: {lat: 53.385873, long: -1.471471}
  end

  private

  def checkin_params(location, params)
    checkin_info = {}
    checkin_info[:user_id] = params[:user][:user_id]
    checkin_info[:location_id] = location.id
    checkin_info.require("CheckIn").permit(:user_id, :location_id)
  end

  def location_params(params)
    location_info = params[:location]
    location_info.require("location").permit(:name, :venue_type, :latitude, :longitude, :address)
  end

  def logout
    session.clear
    redirect_to root_path
  end

  private

  def checkin_creator(location, params)
    checkin = CheckIn.new
    checkin.user_id = params[:user][:user_id]
    checkin.location_id = location.id
    checkin
  end

  def location_creator(params)
    location = Location.new
    location.name = params[:location][:name]
    location.venue_type = params[:location][:venue_type]
    location.latitude = params[:location][:latitude]
    location.longitude = params[:location][:longitude]
    location.address= params[:location][:address]
    location
  end

end
