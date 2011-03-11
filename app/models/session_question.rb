class SessionQuestion < ActiveRecord::Base

	belongs_to :session
	belongs_to :question
	
	def SessionQuestion.generate_for_session(session, how_many = 10)
		questions = session.venue.questions
		questions.each do |q|
			SessionQuestion.create(:session_id => session.id, :question_id => q.id)
		end
	end
	
	def as_json(options={})
		question
	end
	
end
