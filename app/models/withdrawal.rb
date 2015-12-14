class Withdrawal < ActiveRecord::Base
	belongs_to :user
	validates :amount, numericality: { greater_than: 0 }
	attr_accessor :email
end
