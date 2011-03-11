class CategoryRelation < ActiveRecord::Base

	def CategoryRelation.our_tag_category(fsq_tag)
		our_topic = CategoryRelation.all.select { |cr| fsq_tag.downcase == cr.fsq_tag.downcase }.first if fsq_tag
		our_tag = our_topic.our_tag if our_topic
		if  !our_tag || our_tag == ""
			"General"
		else
			our_tag
		end
	end

end
