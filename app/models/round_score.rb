class RoundScore < ActiveRecord::Base

	belongs_to :player
	belongs_to :session

	def RoundScore.leaderboard(session)
		RoundScore.where(:session_id => session.id).sort{|a,b|b.score<=>a.score}.map{|a|{:name=>a.player.name,:score=>a.score}}
	end
	
	def RoundScore.add_score(player, session, score)
		RoundScore.create(:player_id => player.id, :session_id => session.id, :score => score)
	end

end
