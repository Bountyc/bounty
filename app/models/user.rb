class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
	
    validates_presence_of [:first_name, :last_name]

	has_many :bounty_hunters

	has_many :payments

	has_many :answers, through: :bounty_hunters, source: :answer

	has_many :bounties, :foreign_key => "poster_id"

	has_many :disputes_won, :class_name => "Dispute", :foreign_key => "winner_user_id"

	has_many :disputes_moderated, :class_name => "Dispute", :foreign_key => "moderator_id"

	# TODO think of a better name instead of hunting bounties
	has_many :hunting_bounties, through: :bounty_hunters, source: :bounty
	
	has_many :notifications

	has_many :withdrawals

	has_many :views

	has_many :tag_reputations, foreign_key: "user_id", class_name: "UserTagReputation"

	def solved_bounties
		Bounty.joins(:bounty_hunters).where("bounty_hunters.status = 3").where("bounty_hunters.user_id = ?", [self.id])
	end

	def working_on_bounties
		Bounty.joins(:bounty_hunters).where("bounty_hunters.status = 0").where("bounty_hunters.user_id = ?", [self.id])
	end

	def bounties_with_rejected_answer
		Bounty.joins(:bounty_hunters).where("bounty_hunters.status = 2").where("bounty_hunters.user_id = ?", [self.id])
	end

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|

	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.first_name = auth.info.name.split()[0]
	    user.last_name = auth.info.name.split()[1..-1].join(" ")
	  end
	end

	def reload_balance
		total_payments = 0
		self.payments.each do |payment|
  			total_payments += payment.amount
		end

		total_withdrawals = 0
		self.withdrawals.each do |withdrawal|
			total_withdrawals += withdrawal.amount
		end

		total_bounties_won_amount = 0
		self.bounty_hunters.each do |hunting_bounty|
			if hunting_bounty.approved?
				total_bounties_won_amount += hunting_bounty.bounty.price
			end
		end

		total_bounties_lost_amount = 0
		self.bounties.each do |bounty|
			total_bounties_lost_amount += bounty.price
		end

		self.balance = total_payments + total_bounties_won_amount - total_withdrawals - total_bounties_lost_amount
		self.save
		self.balance
	end

	def reload_reputation

		tags_reputation = {} # Hash with format {tag_string: score} 
		reputation = 0
		# -----------  Reload reputation by rejected bounties ------------
		# Need to call first because returns array with one object
		rejected_score = ActionReputationScore.answer_rejected.first.score
		self.bounties_with_rejected_answer.each do |bounty|
			tags_count = 0
			tags_reputation_for_bounty = 0
			bounty.tags.each do |tag|
				if tags_reputation.has_key?(tag.id)
					tags_reputation[tag.id] += rejected_score
				else
					# if tag is not in hash += will raise an error
					tags_reputation[tag.id] = rejected_score
				end

				tags_reputation_for_bounty += rejected_score
				tags_count+=1
			end
			
			reputation += (tags_reputation_for_bounty/tags_count) unless 0 == tags_count
		end
		# ----------------------------------------------------------------
		# -----------  Reload reputation by resolved bounties ------------
		# Need to call first because returns array with one object
		rejected_score = ActionReputationScore.resolve_bounty.first.score
		self.solved_bounties.each do |bounty|
			tags_count = 0
			tags_reputation_for_bounty = 0
			bounty.tags.each do |tag|
				if tags_reputation.has_key?(tag.id)
					tags_reputation[tag.id] += rejected_score
				else
					# if tag is not in hash += will raise an error
					tags_reputation[tag.id] = rejected_score
				end
				tags_reputation_for_bounty += rejected_score
				tags_count+=1
			end
			reputation += (tags_reputation_for_bounty/tags_count) unless 0 == tags_count
		end
		# ----------------------------------------------------------------


		# -----------  Reload reputation by posted bounties ------------
		# Need to call first because returns array with one object
		rejected_score = ActionReputationScore.post_bounty.first.score
		self.bounties.each do |bounty|
			tags_count = 0
			tags_reputation_for_bounty = 0
			bounty.tags.each do |tag|
				if tags_reputation.has_key?(tag.id)
					tags_reputation[tag.id] += rejected_score
				else
					# if tag is not in hash += will raise an error
					tags_reputation[tag.id] = rejected_score
				end

				tags_reputation_for_bounty += rejected_score
				tags_count+=1
			end
			reputation += (tags_reputation_for_bounty/tags_count) unless 0 == tags_count
		end
		# ----------------------------------------------------------------

		disputes_score = 0.5 # ActionReputationScore.resolve_bounty.first.score
		self.disputes_moderated.each do |dispute|

			unless dispute.bounty_hunter.approved? || dispute.bounty_hunter.dispute_denied?
				next
			end
			bounty = dispute.bounty
			tags_count = 0
			tags_reputation_for_bounty = 0
			bounty.tags.each do |tag|
				if tags_reputation.has_key?(tag.id)
					tags_reputation[tag.id] += disputes_score*bounty.price
				else
					# if tag is not in hash += will raise an error
					tags_reputation[tag.id] = disputes_score*bounty.price
				end

				tags_reputation_for_bounty += disputes_score*bounty.price
				tags_count+=1
			end
			reputation += (tags_reputation_for_bounty/tags_count) unless 0 == tags_count
		end

		# Make sure all reputation tags score not in array deleted
		self.tag_reputations.where.not(tag: tags_reputation.keys).destroy_all

		# Update all reputation tags score of tags in array
		tags_reputation.each do |tag_id, score|
			# TODO handle errors

			tag_reputation = self.tag_reputations.find_by_tag_id(tag_id)

			if tag_reputation.nil?
				# If counln't find, create a new tag_reputation
				tag_reputation = UserTagReputation.new
				tag_reputation.user = self
				tag_reputation.tag_id = tag_id
				tag_reputation.score = score
				tag_reputation.save
			else
				tag_reputation.update(score: score)

			end
		end

		self.reputation = reputation
		self.save
	end
end
