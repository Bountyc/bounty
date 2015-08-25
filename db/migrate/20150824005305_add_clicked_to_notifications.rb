class AddClickedToNotifications < ActiveRecord::Migration
  def change
  	add_column :notifications, :clicked, :boolean, :default => false
  end
end
