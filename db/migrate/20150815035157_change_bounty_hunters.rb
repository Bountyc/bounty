class ChangeBountyHunters < ActiveRecord::Migration
  def change
  	add_reference :bounty_hunters, :answer, index: true
  end
end
