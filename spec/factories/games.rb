FactoryBot.define do
  factory :game do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(random_sentences_to_add: 4) }
    image { nil }
    min_level { Faker::Number.within(range: 1..5) }
    max_level { Faker::Number.within(range: 5..10) }
    game_system { Faker::Games::DnD.klass }
    max_players { Faker::Number.within(range: 3..7) }
    player_count { Faker::Number.between(from: 0, to: max_players) }
    start_date { Faker::Time.between_dates(from: Date.new(1975, 01, 01), to: Date.today, format: :default) }
    association :user
  end
end
