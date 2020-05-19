require 'rails_helper'

RSpec.describe Enemy, type: :model do
  before(:all) do
  	@enemy = create(:enemy)
  end

  it "has invalid level" do
  	level = FFaker::Random.rand(100..999)

  	enemy = build(:enemy, level: level)
  	expect(enemy).to_not be_valid
  end

  it "verify current power" do
  	expect(@enemy.current_power).to eq(@enemy.power_base + ((@enemy.level - 1) * @enemy.power_step))
  end
end
