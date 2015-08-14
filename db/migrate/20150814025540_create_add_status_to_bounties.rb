class CreateAddStatusToBounties < ActiveRecord::Migration
  def change
    create_table :add_status_to_bounties do |t|
      t.integer :status

      t.timestamps null: false
    end
  end
end
