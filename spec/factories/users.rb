FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username(specifier: 5..30) }
    password { '12345user' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }

    trait :role_game_master do
      after(:create) { |user| create(:game_master, user: user) }
    end

    trait :role_admin do
      after(:create) { |user| create(:user_role, :role_admin, user: user) }
    end

    trait :role_superadmin do
      after(:create) { |user| create(:user_role, :role_superadmin, user: user) }
    end

    factory :user_with_games do
      transient do
        games_count { 1 }
      end

      after(:create) do |user, evaluator|
        create_list(:game, evaluator.games_count, user: user)

        user.reload
      end
    end

    factory :user_with_character do
      transient do
        characters_count { 1 }
      end

      after(:create) do |user, evaluator|
        create_list(:character, evaluator.characters_count, user: user)

        user.reload
      end
    end
  end
end
