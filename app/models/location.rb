class Location < ActiveRecord::Base
  has_many :checkpoints
  has_many :quests, through: :checkpoints
  has_many :check_ins
  has_many :users, through: :check_ins

  after_validation :add_address
  # geocoded_by :address
  before_create :get_latlng

  private

  def add_address
    self.address = [self.street, self.city, self.state, self.zip].join(', ')
  end

  def get_latlng
    address = [self.street.split(' '), self.city.split(' '), self.state.split(' '), self.zip].join('%20')
    url = "open.mapquestapi.com"
    request = "/geocoding/v1/address/?key=" + ENV["MAP_KEY"] + "&location=" + address
    response = JSON.parse(Net::HTTP.get_response(url,request).body)
    self.latitude = response["results"][0]["locations"][0]["latLng"]["lat"]
    self.longitude = response["results"][0]["locations"][0]["latLng"]["lng"]
  end
end

#Fmjtd%7Cluur2001n5%2Cbs%3Do5-9a15ly  