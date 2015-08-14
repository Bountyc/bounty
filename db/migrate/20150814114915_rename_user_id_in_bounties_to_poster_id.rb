class RenameUserIdInBountiesToPosterId < ActiveRecord::Migration
  def change
  	rename_column :bounties, :user_id, :poster_id
  end
end
