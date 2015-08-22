class Notification < ActiveRecord::Base
	belongs_to :bounty_hunter
	belongs_to :user

	enum notification_type: [:answer_denied, :answer_accepted, :new_answer, :started_working]
	default_scope {order('updated_at DESC')}

end
