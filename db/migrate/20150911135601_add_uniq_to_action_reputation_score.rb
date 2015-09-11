class AddUniqToActionReputationScore < ActiveRecord::Migration
  def change
  		add_index :action_reputation_scores, :action, unique: true
  end
end
