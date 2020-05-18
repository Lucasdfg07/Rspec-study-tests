FactoryBot.define do
  factory :weapon do
    name {FFaker::Lorem.word}
    description {FFaker::Lorem.paragraph}
    level {FFaker::Random.rand(1..99)}
  end
end
