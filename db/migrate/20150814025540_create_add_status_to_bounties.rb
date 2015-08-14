class CreateAddStatusToBounties < ActiveRecord::Migration
  def change
    add_column :bounties, :status, :integer, default: 0
  end
end
