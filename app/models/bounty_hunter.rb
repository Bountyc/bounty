class BountyHunter < ActiveRecord::Base
	has_many :notification

	belongs_to :hunter, :class_name => "User", :foreign_key => "user_id"
	belongs_to :bounty
	belongs_to :answer

	enum status: [:working, :requesting, :denied, :approved]

end
