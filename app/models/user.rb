class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :bounty_hunters

	has_many :payments

	has_many :answers
	has_many :bounties, :foreign_key => "poster_id"

	# TODO think of a better name instead of hunting bounties
	has_many :hunting_bounties, through: :bounty_hunters, source: :bounty

	has_many :withdrawals

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
		self.hunting_bounties.each do |hunting_bounty|
			if hunting_bounty.status == :approved
				
			end
		end
	end
end
