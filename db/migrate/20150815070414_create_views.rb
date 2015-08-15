class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
    	t.references :bounty
    	t.references :user
    	t.timestamps null: false
    end
  end
end
