class Tag < ActiveRecord::Base
	has_many :user_tag_reputations
end
