class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
    	t.string :transaction_id
    	t.references :user
    	t.float :amount
    	
    	t.timestamps null: false
    end
    add_index :payments, ["user_id"]

  end
end
