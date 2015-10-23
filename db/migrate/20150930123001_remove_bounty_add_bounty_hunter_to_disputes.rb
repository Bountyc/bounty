class RemoveBountyAddBountyHunterToDisputes < ActiveRecord::Migration
  def change
  	remove_column :disputes, :bounty_id
  	add_column :disputes, :bounty_hunter_id, :integer
  end
end
