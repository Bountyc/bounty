require 'rails_helper'

RSpec.describe User, type: :model do

	it 'Should not create user without first name, last name' do
		u = User.new
		u.email = "dkgs1998@gmail.com"
		u.password = "12345678"
		u.password_confirmation = "12345678"

		u.validate #needed in order to fetch errors

		expect(u.errors.keys).to eq [:first_name, :last_name] 
	end

	it 'Should create user if first and last name are given' do
		u = User.new
		u.email = "dkgs1998@gmail.com"
		u.first_name = "Gilad"
		u.last_name = "Kleinman"
		u.password = "12345678"
		u.password_confirmation = "12345678"

		expect(u.save).to eq true
	end

	it 'Should not create user without email' do
		u = User.new
		u.first_name = "Gilad"
		u.last_name = "Kleinman"
		u.password = "12345678"
		u.password_confirmation = "12345678"

		u.validate #needed in order to fetch errors

		expect(u.errors.keys).to eq [:email] 
	end

	it 'Should create user if email is given' do
		u = User.new
		u.email = "dkgs1998@gmail.com"
		u.first_name = "Gilad"
		u.last_name = "Kleinman"
		u.password = "12345678"
		u.password_confirmation = "12345678"

		expect(u.save).to eq true
	end
end
