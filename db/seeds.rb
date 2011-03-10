# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Question.delete_all
q1 = Question.create(:text => "What is your name?", :answer_id => 1)
q2 = Question.create(:text => "What is your name 2?", :answer_id => 5)
q3 = Question.create(:text => "What is your name 3?", :answer_id => 9)

QuestionResponse.delete_all
QuestionResponse.create(:text => "Birdie", :question_id => q1.id)
QuestionResponse.create(:text => "Birdie2", :question_id => q1.id)
QuestionResponse.create(:text => "Birdie3", :question_id => q1.id)
a1 = QuestionResponse.create(:text => "Birdie4", :question_id => q1.id)
a2 = QuestionResponse.create(:text => "Doggy", :question_id => q2.id)
QuestionResponse.create(:text => "Doggy2", :question_id => q2.id)
QuestionResponse.create(:text => "Doggy3", :question_id => q2.id)
QuestionResponse.create(:text => "Doggy4", :question_id => q2.id)
QuestionResponse.create(:text => "Tweetie", :question_id => q3.id)
QuestionResponse.create(:text => "Tweetie2", :question_id => q3.id)
a3 = QuestionResponse.create(:text => "Tweetie3", :question_id => q3.id)
QuestionResponse.create(:text => "Tweetie4", :question_id => q3.id)
q1.answer_id = a1.id
q1.save
q2.answer_id = a2.id
q2.save
q3.answer_id = a3.id
q3.save

CategoryRelation.delete_all
CategoryRelation.create(:our_tag => "Games", :fsq_tag => "Arcades")
CategoryRelation.create(:our_tag => "Games", :fsq_tag => "Bowling Alleys")
CategoryRelation.create(:our_tag => "Games", :fsq_tag => "Casinos")
CategoryRelation.create(:our_tag => "Games", :fsq_tag => "Gaming Cafes")
CategoryRelation.create(:our_tag => "TV & Film", :fsq_tag => "Movie Theaters")
CategoryRelation.create(:our_tag => "History", :fsq_tag => "History Museums")
CategoryRelation.create(:our_tag => "Science", :fsq_tag => "Planetariums")
CategoryRelation.create(:our_tag => "Science", :fsq_tag => "Science Museums")
CategoryRelation.create(:our_tag => "Music", :fsq_tag => "Music Venues")
CategoryRelation.create(:our_tag => "Games", :fsq_tag => "Pool Halls")
CategoryRelation.create(:our_tag => "Sport", :fsq_tag => "Stadiums")
CategoryRelation.create(:our_tag => "Food & Drink", :fsq_tag => "Food")
CategoryRelation.create(:our_tag => "Sport", :fsq_tag => "Baseball Fields")
CategoryRelation.create(:our_tag => "Sport", :fsq_tag => "Basketball Courts")
CategoryRelation.create(:our_tag => "Sport", :fsq_tag => "Golf Courses")
CategoryRelation.create(:our_tag => "Sport", :fsq_tag => "Ski Areas")
CategoryRelation.create(:our_tag => "Sport", :fsq_tag => "Soccer Fields")
CategoryRelation.create(:our_tag => "Tech", :fsq_tag => "Convention Centers")
CategoryRelation.create(:our_tag => "Music", :fsq_tag => "Music Venues")
CategoryRelation.create(:our_tag => "Literature", :fsq_tag => "Bookstores")
CategoryRelation.create(:our_tag => "Food & Drink", :fsq_tag => "Food and Drink Shops")

load 'import_questions.rb'

#VenueQuestionRelation.delete_all
#VenueQuestionRelation.create(:venue_id => v1.id, :question_id => q1.id)
#VenueQuestionRelation.create(:venue_id => v1.id, :question_id => q2.id)
#VenueQuestionRelation.create(:venue_id => v1.id, :question_id => q3.id)
#VenueQuestionRelation.create(:venue_id => v2.id, :question_id => q1.id)