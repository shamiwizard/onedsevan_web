# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

2.times do |n|
  user = FactoryBot.create(:user, username: "player-#{n}")
  puts "User #{user.username} created!"
end

%i[superadmin admin game_master].each do |role|
  2.times do |n|
    user = FactoryBot.create(:user, "role-#{role}", username: "#{role}_#{n}")
    puts "User #{user.username} created!"
  end
end