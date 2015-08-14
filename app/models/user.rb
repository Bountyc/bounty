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
end
