FactoryBot.define do
  factory :user do
    username { Faker::Movies::LordOfTheRings.character }
    password { 'password'}

    factory :schmiegel do
      username {'Schmiegel'}
    end
  end
end
