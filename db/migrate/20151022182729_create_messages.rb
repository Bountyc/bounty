class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.references :dispute
    	t.references :user
    	t.text :contents
    	t.timestamps null: false
    end
  end
end
