FactoryBot.define do
  factory :game_master do
    association :user
    description { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
  end
end
