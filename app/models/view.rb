class View < ActiveRecord::Base
	belongs_to :bounty
	belongs_to :user
end
