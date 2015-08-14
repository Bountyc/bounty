class CreateBountyHunters < ActiveRecord::Migration
  def change
    create_table :bounty_hunters do |t|
    	t.references :user
    	t.references :bounty
    	t.integer :status

    	t.timestamps null: false
    end
    add_index :bounty_hunters, ["user_id", "bounty_id"]
  end
end
