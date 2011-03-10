class QuestionResponse < ActiveRecord::Base

	belongs_to :question
	
	def as_json(options={})
		{:id => id, :text => text}
	end

end
