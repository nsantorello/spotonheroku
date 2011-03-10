class ApiController < ApplicationController

	def venues
		render :json => Venue.all
	end
	
	def venues_leaderboard
		render :json => Venue.find(params[:venue_id]).leaderboard
	end
	
end