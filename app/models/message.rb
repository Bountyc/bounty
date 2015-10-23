class Message < ActiveRecord::Base
	belongs_to :dispute
	belongs_to :user
end
