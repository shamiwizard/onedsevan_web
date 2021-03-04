FactoryBot.define do
  factory :character do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    level { rand(1..10) }
    speciality { Faker::Games::DnD.klass }
    race { Faker::Games::DnD.race }
    association :user
  end
end
