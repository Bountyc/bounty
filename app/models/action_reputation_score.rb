class ActionReputationScore < ActiveRecord::Base
	validates_presence_of [:action, :score]

	enum action: [:resolve_bounty, :answer_rejected, :post_bounty, :resolve_dispute]
end
