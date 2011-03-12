class Player < ActiveRecord::Base

	has_many :score_histories
	
	def score_at_venue(venue)
		score_history_at(venue).inject(0) { |acc, sh| acc += sh.score }
	end
	
	def score(session, answers)
		questions = session.time_valid_questions
		# Check if you've answered for this round and if we have the same number of answers as questions.
		if (questions.count == answers.count && !RoundScore.where(:player_id => id, :session_id => session.id).first)
			round_score = (0..answers.count-1).to_a.map{|i| (questions[i].question.answer_id == answers[i].to_i && 1) || 0}.inject(0){|acc,sc|acc+=sc}
			# Create a score for the round.
			if round_score >= 5
				self.treats += 1
				self.save
			end
			RoundScore.add_score(self, session, round_score)
			ScoreHistory.get_today_or_create(self, session.venue).add_score(round_score)
			return round_score >= 5
		else
			return false
		end
	end
	
	def name
		first_name + " " + last_name
	end
	
	def score_history_at(venue)
		score_histories.where(:venue_id => venue.id)
	end
	
	def score_history_today_at(venue)
		ScoreHistory.get_today_or_create(self, venue)
	end

end
