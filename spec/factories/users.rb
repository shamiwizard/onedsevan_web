FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    # username { Faker::Internet.username }
    password { '12345user' }

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
