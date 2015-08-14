class CreateBounties < ActiveRecord::Migration
  def change
    create_table :bounties do |t|
      t.string :title
      t.string :description
      t.integer :views
      t.float :price

      t.timestamps null: false
    end
  end
end
