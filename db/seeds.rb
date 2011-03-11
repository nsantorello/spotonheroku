file = File.new("db/questions.csv", "r")
delim = "|"

QuestionResponse.delete_all
Question.delete_all

responses = []

while (line = file.gets)
	# Create responses
	#puts line
	tokens = line.split(delim)
	choices = tokens[1..4].map do |r|
		QuestionResponse.create(:text => r)
	end
	
	question = Question.create(:text => tokens[0].strip, :answer_id => choices[0].id.strip, :tag => tokens[5].strip)
	
	choices.each do |c|
		c.question_id = question.id
		c.save
	end
end

file.close

file = File.new("db/category_relations.csv", "r")

delim = "|"

CategoryRelation.delete_all

while (line = file.gets)
	tokens = line.split(delim)
	CategoryRelation.create(:fsq_tag => tokens[1].strip, :our_tag => tokens[0].strip)
end

file.close