puts "Perform Question Import? y/n"
skip = (gets != 'y')
if !skip
	puts "Questions Filename?"
	file = File.new(gets.strip, "r")
	puts "Delimiter?"
	delim = gets.strip
	puts "Skip first line? y/n"
	file.gets if gets == "y"
	
	QuestionResponse.delete_all
	Question.delete_all
	
	responses = []
	
	while (line = file.gets)
		# Create responses
		puts line
		tokens = line.split(delim)
		choices = tokens[1..4].map do |r|
			QuestionResponse.create(:text => r)
		end
		
		question = Question.create(:text => tokens[0], :answer_id => choices[0].id, :tag => tokens[5])
		
		choices.each do |c|
			c.question_id = question.id
			c.save
		end
	end
	
	file.close
end

puts "Perform Category Relations Import? y/n"
skip = (gets == 'y')
if !skip
	puts "Relations Filename?"
	file = File.new(gets.strip, "r")
	puts "Delimiter?"
	delim = gets.strip
	puts "Skip first line? y/n"
	file.gets if gets == "y"
	
	CategoryRelation.delete_all
	
	while (line = file.gets)
		tokens = line.split(delim)
		CategoryRelation.create(:fsq_tag => tokens[1], :our_tag => tokens[0])
	end
	
	file.close
end