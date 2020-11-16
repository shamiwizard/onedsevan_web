FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username }
    password { '12345user' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }

    trait :role_player do
      role { :PLAYER }
    end

    trait :role_dm do
      role { :DM }
    end

    trait :role_dm do
      role { :ADMIN }
    end

    trait :role_admin do
      role { :ADMIN }
    end

    trait :role_superadmin do
      role { :SUPERADMIN }
    end
  end
end
