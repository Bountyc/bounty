class Dispute < ActiveRecord::Base
	belongs_to :bounty
	belongs_to :winner_user, :class_name => "User", :foreign_key => "winner_user_id"
	belongs_to :moderator, :class_name => "User", :foreign_key => "moderator_id"

end
