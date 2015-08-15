class Notification < ActiveRecord::Base
	belongs_to :bounty_hunter
	belongs_to :user

	enum notification_type: [:answer_denied, :answer_accepted]
end
