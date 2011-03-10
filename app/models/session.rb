class Session < ActiveRecord::Base

	belongs_to :venue
	has_many :session_questions

	def Session.create_or_get_for_venue(venue)
		venue.valid_session || Session.create_for_venue(venue)
	end

	def Session.create_for_venue(venue)
		# Create time windows.
		now = Time.new
		start_time = now + 0.seconds
		end_time = start_time + 112.minutes + 30.seconds
		# Create the new session.
		session = Session.create(:start_time => start_time, :end_time => end_time, :venue_id => venue.id)
		# Generate random questions for this session.
		SessionQuestion.generate_for_session(session)
		session
	end
	
	def valid_right_now
		now = Time.new
		now >= start_time && now <= end_time
	end
	
	def as_json(options={})
		{ :id => id, :start_time => start_time, :end_time => end_time }
	end
	
	def time_valid_questions
		session_questions if valid_right_now
	end

end
