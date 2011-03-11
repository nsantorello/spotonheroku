class Venue < ActiveRecord::Base

	has_many :venue_question_relations
	#has_many :questions, :through => :venue_question_relations
	has_many :sessions
	has_many :score_histories
	
	def valid_session
		sessions.select { |sess| Time.new < sess.end_time }.first
	end
	
	def score_for_player(player)
		score_histories.where(:player_id => player.id).inject(0) { |acc, sh| acc += sh.score }
	end
	
	def as_json(options={})
		{:name => name, :description => description, :id => id}
	end
	
	def leaderboard
		unique_sessions = ScoreHistory.where(:venue_id => id).uniq{|sh|sh.player.id}.sort {|a,b|b.player.score_at_venue(self) <=> a.player.score_at_venue(self)}
		scores = unique_sessions.map { |s| { :name => s.player.name, :score => s.player.score_at_venue(self) } }
	end
	
	
	def questions
		# Our category
		# description == 4sq category
		
		if description == "General"
			# Select from all questions.
			Question.all.sample(10)
		else
			Question.where(:tag => description).sample(10)
		end
	end

end
