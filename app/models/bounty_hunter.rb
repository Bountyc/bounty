class BountyHunter < ActiveRecord::Base
	belongs_to :hunter, :class_name => "User", :foreign_key => "user_id"
	belongs_to :bounty
end
