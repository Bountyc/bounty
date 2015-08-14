class Bounty < ActiveRecord::Base
	has_many :bounty_hunters
	has_many :hunters, through: :bounty_hunters
	belongs_to :poster, :class_name => "User", :foreign_key => "user_id"
	
end
