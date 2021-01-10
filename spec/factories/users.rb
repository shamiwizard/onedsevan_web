FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username(specifier: 5..30) }
    password { '12345user' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }

    trait :role_game_master do
      user_roles { [association(:user_role, :role_game_master)] }
    end

    trait :with_game_master do
      association :game_master
    end

    trait :role_admin do
      user_roles { [association(:user_role, :role_admin)] }
    end

    trait :role_superadmin do
      user_roles { [association(:user_role, :role_superadmin)] }
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
