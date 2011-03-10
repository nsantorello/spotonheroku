class SessionsController < ApplicationController
	
	def play_request
		venue = Venue.find(params[:venue_id])
		session = Session.create_or_get_for_venue(venue)
		
		render :json => session
	end
	
	def play_questions
		session = Session.find(params[:session_id])
		
		render :json => session.time_valid_questions
	end
	
	def play_submit
		player = Player.find(params[:player_id])
		session = Session.find(params[:session_id])
		answers = eval('[' + params[:answers] + ']')
		# Save player's score.
		player.score(session, answers)
		
		render :json => 1
	end
	
	def play_results
		session = Session.find(params[:session_id])
		
		render :json => RoundScore.leaderboard(session)
	end
	
end