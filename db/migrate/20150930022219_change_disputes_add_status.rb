class ChangeDisputesAddStatus < ActiveRecord::Migration
  def change
  	add_column :disputes, :status, :int, :default => 0
  end
end
