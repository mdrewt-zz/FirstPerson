module QuestsHelper

#need another method in here to check step num, this is rudimentary
	def quest_check(user, location)
		accepted_quests = user.quests
		accepted_quests.each do |quest|
			quest.locations.each do |loc|
				if loc.foursquare_id == location.foursquare_id
					checkpoint = quest.checkpoints.find_by(location_id: loc.id)
					checkpoint.user_checkponts.find_by(user_id: user.id).update(completed: true)
				end
			end
		end
	end

end
