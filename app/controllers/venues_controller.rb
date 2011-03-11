class VenuesController < ApplicationController
  	def get_venues2  	
		render :json => Venue.all
	end
	
	def get_venues
  		venues_url = "https://api.foursquare.com/v2/venues/search?ll=#{params[:lat]},#{params[:lon]}&oauth_token=#{Player.find(params[:player_id]).foursquare_access_token}"
  		puts venues_url
  		call = JSON.parse(`curl '#{venues_url}'`)
  		
  		nearby_venues = []
  		
  		call["response"]["groups"].each do |c|
			d["items"].each { |v|
				if !(near_venue = Venue.where(:foursquare_id => v["id"]).first)
					near_venue = Venue.new
					near_venue.name = v["name"]
					near_venue.description = v["categories"] && v["categories"][0] && v["categories"][0]["name"]
					near_venue.foursquare_id = v["id"]
					near_venue.save
				end
				
				hash = {:name=>near_venue.name, :description=>near_venue.description, :id => near_venue.id, :distance=>v["location"]["distance"].to_i}
				
				nearby_venues << hash
			}
		end
  	
		render :json => nearby_venues.sort{ |a,b|a[:distance] <=> b[:distance] }
	end
	
	def venues_leaderboard
		render :json => Venue.find(params[:venue_id]).leaderboard
	end
end
