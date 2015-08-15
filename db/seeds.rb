# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u1 = User.new
u1.email = "dkgs1998@gmail.com"
u1.password = "12345678"
u1.password_confirmation = "12345678"
u1.balance = 99999
u1.save

u2 = User.new
u2.email = "maor.kern@gmail.com"
u2.password = "12345678"
u2.password_confirmation = "12345678"
u2.balance = 1
u2.save

u3 = User.new
u3.email = "shut@fuck.up"
u3.password = "I'm so tired"
u3.password_confirmation = "I'm so tired"
u1.balance = 99999
u3.save

b1 = Bounty.new
b1.poster = u1
b1.price = 50
b1.title = "I need help"
b1.description = "With writing this seeds file"
b1.open!
b1.save

b1.hunters << u3
b1.hunters << u2

a = Answer.new
a.description = "title"
bh1 = b1.bounty_hunters.where(hunter: u2).first
bh1.answer = a
a.save