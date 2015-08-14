class Bounty < ActiveRecord::Base
	
	has_many :bounty_hunters
	has_many :hunters, through: :bounty_hunters

	has_and_belongs_to_many :tags

	has_many :answers
	belongs_to :poster, :class_name => "User", :foreign_key => "poster_id"
	
	enum status: [:open, :pending, :closed]
end
