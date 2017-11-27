FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password 'secretPassword'
    password_confirmation 'secretPassword'
  end

  factory :game do
    name 'game1'
    association :user
  end

  factory :piece do
    type 'Rook'
    color :white
    association :game
  end

  factory :king do
    association :game
  end

  factory :bishop do
    association :game
  end

  factory :queen do
    association :game
  end
end
