class ChangeAnswersTable < ActiveRecord::Migration
  def change
  	remove_reference :answers, :bounty, index: true
  end
end
