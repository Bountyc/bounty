class CreateActionReputationScores < ActiveRecord::Migration
  def change
    create_table :action_reputation_scores do |t|
    	t.integer :action
    	t.integer :score
    	t.timestamps null: false
    end
  end
end
