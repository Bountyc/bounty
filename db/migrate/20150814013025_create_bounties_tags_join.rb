class CreateBountiesTagsJoin < ActiveRecord::Migration
  def change
    create_table :bounties_tags_joins, :id => false do |t|
    	t.integer "bounty_id"
    	t.integer "tag_id"
    end
    add_index :bounties_tags_joins, ["bounty_id","tag_id"]
  end
end
