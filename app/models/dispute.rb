class Dispute < ActiveRecord::Base
	belongs_to :bounty_hunter
	belongs_to :winner_user, :class_name => "User", :foreign_key => "winner_user_id"
	belongs_to :moderator, :class_name => "User", :foreign_key => "moderator_id"

	enum status: [:open, :closed]

	scope :search, -> (field, text) { where("#{field} LIKE ?", "%#{text}%") }

	has_one :hunter, through: :bounty_hunter, source: :hunter
	has_one :bounty, through: :bounty_hunter, source: :bounty
	has_one :poster, through: :bounty, source: :poster

	has_many :messages
end
