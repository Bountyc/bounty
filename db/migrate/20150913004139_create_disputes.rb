class CreateDisputes < ActiveRecord::Migration
  def change
    create_table :disputes do |t|
    	t.integer "bounty_id"
		t.integer "winner_user_id"
    	t.integer "moderator_id"
      	t.timestamps null: false
    end
  end
end
