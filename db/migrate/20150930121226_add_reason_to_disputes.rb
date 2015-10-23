class AddReasonToDisputes < ActiveRecord::Migration
  def change
  	add_column :disputes, :reason, :text
  end
end
