class CreateBountyMessages < ActiveRecord::Migration
  def change
    create_table :bounty_messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :message

      t.timestamps null: false
    end
  end
end
