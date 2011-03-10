class Question < ActiveRecord::Base
	has_many :question_responses
	has_many :venue_question_relations
	has_many :venues, :through => :venue_question_relations
	
	attr_accessor :responses
	
	def responses
		question_responses
	end
	
	def encode_json(arg)
		self.to_json
	end
	
	def as_json(options = {})
		{:id => id, :text => text, :answer_id => answer_id, :responses => question_responses}
	end
end
