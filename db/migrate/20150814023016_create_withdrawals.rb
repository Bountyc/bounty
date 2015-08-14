class CreateWithdrawals < ActiveRecord::Migration
  def change
    create_table :withdrawals do |t|
    	t.references :user
    	t.float :amount

    	t.timestamps null: false
    end
  end
end
