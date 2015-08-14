class ChangeJoinTableName < ActiveRecord::Migration
  def change
  	rename_table :bounties_tags_joins, :bounties_tags
  end
end
