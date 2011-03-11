class SessionsController < ApplicationController
	
	def play_request
		venue = Venue.find(params[:venue_id])
		session = Session.create_or_get_for_venue(venue)
		#if !SessionPlayer.where(:player_id => params[:player_id], :session_id => session.id).first
		#	SessionPlayer.create(:player_id => params[:player_id], :session_id => session.id)
		#end
		
		render :json => session
	end
	
	def play_questions
		session = Session.find(params[:session_id])
		#session_players = SessionPlayer.all
		
		render :json => session.time_valid_questions
	end
	
	def play_submit
		player = Player.find(params[:player_id])
		session = Session.find(params[:session_id])
		answers = eval('[' + params[:answers] + ']')
		# Save player's score.
		player.score(session, answers)
		
		render :json => Venue.find(session.venue_id).leaderboard
	end
	
	def play_results
		session = Session.find(params[:session_id])
		
		render :json => RoundScore.leaderboard(session)
	end
	
end