class ChangeAnswers < ActiveRecord::Migration
  def change
  	add_column :answers, :denial_reason, :text
  end
end
