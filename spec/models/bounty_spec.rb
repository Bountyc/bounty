require 'rails_helper'

RSpec.describe Bounty, type: :model do
  it 'should not save without a poster' do
  	b = Bounty.new
  	b.title = "hi"
  	b.description = "bounty description"
  	b.price = 5
  	b.save

  	expect(b.errors.keys).to eq [:poster_id]
  end

  it 'should not save if poster cant afford' do
  	
  end
end
