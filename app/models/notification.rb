class Notification < ActiveRecord::Base
	include Sync::Actions
	belongs_to :bounty_hunter
	belongs_to :user
	enum notification_type: [:answer_denied, :answer_accepted, :new_answer]

	sync_touch :user
	sync :all
end
