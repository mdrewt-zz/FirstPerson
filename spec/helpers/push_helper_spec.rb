require 'rails_helper'

RSpec.describe PushHelper, :type => :helper do
  unformatted_params = {"checkin"=>"{\"id\":\"42\",\"createdAt\":1307778479,\"type\":\"checkin\",\"shout\":\"Yes\",\"timeZoneOffset\":-240,\"user\":{\"id\":\"81231200\",\"firstName\":\"Test\",\"lastName\":\"stuff\",\"gender\":\"male\",\"relationship\":\"self\",\"photo\":{\"prefix\":\"https:\\/\\/irs3.4sqi.net\\/img\\/user\\/\",\"suffix\":\"\\/81231200-3N1S5SNFSCQK.jpg\"}},\"venue\":{\"id\":\"5314cf55498e9cc2143b07f0\",\"name\":\"Dev Bootcamp\",\"contact\":{\"twitter\":\"devbootcamp\"},\"location\":{\"address\":\"48 Wall St Fl 15\",\"crossStreet\":\"William Street\",\"lat\":40.70649115774123,\"lng\":-74.0091286171833,\"postalCode\":\"10005\",\"cc\":\"US\",\"city\":\"New York\",\"state\":\"NY\",\"country\":\"United States\",\"formattedAddress\":[\"48 Wall St Fl 15 (William Street)\",\"New York, NY 10005\"]},\"categories\":[{\"id\":\"4bf58dd8d48988d1ad941735\",\"name\":\"Trade School\",\"pluralName\":\"Trade Schools\",\"shortName\":\"Trade School\",\"icon\":{\"prefix\":\"https:\\/\\/ss1.4sqi.net\\/img\\/categories_v2\\/education\\/tradeschool_\",\"suffix\":\".png\"},\"primary\":true}],\"verified\":false,\"stats\":{\"checkinsCount\":326,\"usersCount\":58,\"tipCount\":0}}}", "user"=>"{\"id\":\"81231200\",\"firstName\":\"Test\",\"lastName\":\"stuff\",\"gender\":\"male\",\"relationship\":\"self\",\"photo\":\"https:\\/\\/is0.4sqi.net\\/userpix_thumbs\\/81231200-3N1S5SNFSCQK.jpg\",\"tips\":{\"count\":0},\"lists\":{\"groups\":[{\"type\":\"created\",\"count\":1,\"items\":[]}]},\"homeCity\":\"NYC\",\"bio\":\"\",\"contact\":{\"email\":\"mstuff13@woot.com\",\"facebook\":\"805802510\"}}", "secret"=>"HAHAGOTCHA"} 
  formatted_params = {"checkin"=>{"id"=>"42", "createdAt"=>1307778479, "type"=>"checkin", "shout"=>"Yes", "timeZoneOffset"=>-240, "user"=>{"id"=>"81231200", "firstName"=>"Test", "lastName"=>"stuff", "gender"=>"male", "relationship"=>"self", "photo"=>{"prefix"=>"https://irs3.4sqi.net/img/user/", "suffix"=>"/81231200-3N1S5SNFSCQK.jpg"}}, "venue"=>{"id"=>"5314cf55498e9cc2143b07f0", "name"=>"Dev Bootcamp", "contact"=>{"twitter"=>"devbootcamp"}, "location"=>{"address"=>"48 Wall St Fl 15", "crossStreet"=>"William Street", "lat"=>40.70649115774123, "lng"=>-74.0091286171833, "postalCode"=>"10005", "cc"=>"US", "city"=>"New York", "state"=>"NY", "country"=>"United States", "formattedAddress"=>["48 Wall St Fl 15 (William Street)", "New York, NY 10005"]}, "categories"=>[{"id"=>"4bf58dd8d48988d1ad941735", "name"=>"Trade School", "pluralName"=>"Trade Schools", "shortName"=>"Trade School", "icon"=>{"prefix"=>"https://ss1.4sqi.net/img/categories_v2/education/tradeschool_", "suffix"=>".png"}, "primary"=>true}], "verified"=>false, "stats"=>{"checkinsCount"=>326, "usersCount"=>58, "tipCount"=>0}}}, "user"=>{"id"=>"81231200", "firstName"=>"Test", "lastName"=>"stuff", "gender"=>"male", "relationship"=>"self", "photo"=>"https://is0.4sqi.net/userpix_thumbs/81231200-3N1S5SNFSCQK.jpg", "tips"=>{"count"=>0}, "lists"=>{"groups"=>[{"type"=>"created", "count"=>1, "items"=>[]}]}, "homeCity"=>"NYC", "bio"=>"", "contact"=>{"email"=>"mstuff13@woot.com", "facebook"=>"805802510"}}}
  final_hash = {:user=>{:user_id=>6}, :location=>{:name=>"Dev Bootcamp", :venue_type=>"Trade School", :second_type=>"Trade School", :latitude=>40.70649115774123, :longitude=>-74.0091286171833, :street=>"48 Wall St Fl 15", :city=>"New York", :state=>"NY", :zip=>"10005", :country=>"US", :foursquare_id=>"5314cf55498e9cc2143b07f0"}}

  it "formats params from foursquare" do
    expect(format(unformatted_params)).to eq(formatted_params)
  end

  it "parses formatted JSON" do
    user = User.create(foursquare_id: 81231200)
    expect(parse_foursquare_json(formatted_params)).to eq(final_hash)
  end

end