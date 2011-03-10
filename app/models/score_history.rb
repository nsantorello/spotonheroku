class ScoreHistory < ActiveRecord::Base

	belongs_to :venue
	belongs_to :player
	
	def ScoreHistory.get_today_or_create(player, venue)
		history = player.score_histories.where(:venue_id => venue.id, :date => Date.today).first
		history || ScoreHistory.create(:player_id => player.id, :venue_id => venue.id, :date => Date.today, :score => 0)
	end
	
	def add_score(score_to_add)
		self.score += score_to_add
		self.save
	end

end
