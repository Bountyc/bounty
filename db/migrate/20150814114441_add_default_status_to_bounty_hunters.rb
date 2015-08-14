class AddDefaultStatusToBountyHunters < ActiveRecord::Migration
  def change
  	change_column :bounty_hunters, :status, :integer, :default => 0
  end
end
