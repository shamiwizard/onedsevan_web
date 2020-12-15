FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username(specifier: 5..30) }
    password { '12345user' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }

    trait :role_player do
      role { 30 }
    end

    trait :role_dm do
      role { 20 }
    end

    trait :role_admin do
      role { 10 }
    end

    trait :role_superadmin do
      role { 0 }
    end

    trait :with_games do
      transient do
        game_count { 1 }
      end

      games do
        Array.new(game_count) { association(:game) }
      end
    end
  end
end
