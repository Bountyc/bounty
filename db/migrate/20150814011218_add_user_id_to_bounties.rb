class AddUserIdToBounties < ActiveRecord::Migration
  def change
  	add_column :bounties, :user_id, :integer
  end
end
