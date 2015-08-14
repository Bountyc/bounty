class Answer < ActiveRecord::Base
	belongs_to :bounty
	belongs_to :user
end
