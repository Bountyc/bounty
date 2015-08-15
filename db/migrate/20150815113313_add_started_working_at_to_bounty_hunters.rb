class AddStartedWorkingAtToBountyHunters < ActiveRecord::Migration
  def change
    add_column :bounty_hunters, :started_working_at, :timestamp
  end
end
