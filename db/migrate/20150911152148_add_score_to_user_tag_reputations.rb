class AddScoreToUserTagReputations < ActiveRecord::Migration
  def change
    add_column :user_tag_reputations, :score, :integer, :default => 0
  end
end
