# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

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

load 'db/import_questions.rb'

#VenueQuestionRelation.delete_all
#VenueQuestionRelation.create(:venue_id => v1.id, :question_id => q1.id)
#VenueQuestionRelation.create(:venue_id => v1.id, :question_id => q2.id)
#VenueQuestionRelation.create(:venue_id => v1.id, :question_id => q3.id)
#VenueQuestionRelation.create(:venue_id => v2.id, :question_id => q1.id)