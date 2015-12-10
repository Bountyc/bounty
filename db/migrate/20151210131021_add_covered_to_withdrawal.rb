class AddCoveredToWithdrawal < ActiveRecord::Migration
  def change
  	add_column :withdrawals, :covered_by_admin, :boolean, :default => false
  end
end
