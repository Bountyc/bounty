class CreateUserTagReputations < ActiveRecord::Migration
  def change
    create_table :user_tag_reputations do |t|
    	t.integer "user_id"
    	t.integer "tag_id"
    end
    add_index :user_tag_reputations, ["user_id", "tag_id"]
  end
end
