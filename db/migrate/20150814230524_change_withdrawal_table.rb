class ChangeWithdrawalTable < ActiveRecord::Migration
  def change
  	add_column :withdrawals, :payout_batch_id, :string
  end
end
