class AddActionToNotification < ActiveRecord::Migration
  def change
  	add_column :notifications, :action_link, :string	
  end
end
