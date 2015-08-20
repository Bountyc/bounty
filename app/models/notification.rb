class Notification < ActiveRecord::Base
	include Sync::Actions
	belongs_to :bounty_hunter
	belongs_to :user
	enum notification_type: [:answer_denied, :answer_accepted, :new_answer]

	sync_touch :user
	before_save :start_sync
	after_save :finish_sync

	def start_sync
		Sync::Model.enable!
	end

	def finish_sync
		Sync::Model.disable!
	end
end
