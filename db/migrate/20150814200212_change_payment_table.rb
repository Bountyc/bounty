class ChangePaymentTable < ActiveRecord::Migration
  def change
  	remove_column :payments, :transaction_id
  	add_column :payments, :payer_id, :string
  	add_column :payments, :payment_id, :string
  end
end
