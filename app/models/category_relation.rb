class CategoryRelation < ActiveRecord::Base

	def CategoryRelation.our_tag_category(fsq_tag)
		our_topic = CategoryRelation.all.select { |cr| fsq_tag.downcase == cr.our_tag.downcase }.first
		if  !our_topic || our_topic == ""
			"General"
		else
			our_topic
		end
	end

end
