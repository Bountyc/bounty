class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	t.references :bounty_hunter
    	t.references :user

     	t.integer :notification_type
     	t.string :message

     	t.boolean :seen
      	t.timestamps null: false
    end
  end
end
