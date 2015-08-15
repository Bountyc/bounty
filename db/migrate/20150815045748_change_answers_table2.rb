class ChangeAnswersTable2 < ActiveRecord::Migration
  def change
  	remove_reference :answers, :user, index: true
  end
end
