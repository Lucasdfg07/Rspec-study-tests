require 'rails_helper'

RSpec.describe User, type: :model do
  it "Is invalid if level is not between 1 and 99" do
  	level = FFaker::Random.rand(100..999)

  	user = build(:user, level: level)
  	expect(user).to_not be_valid	
  end

  it "returns the hero title correctly" do
    nickname = FFaker::Name.first_name
    kind = %i[knight wizard].sample
    level = FFaker::Random.rand(1..99)

  	user = create(:user, nickname: nickname, kind: kind, level: level)
  	expect(user.title).to eq("#{kind} #{nickname} ##{level}")
  end
end
