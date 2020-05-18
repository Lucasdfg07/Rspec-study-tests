require 'rails_helper'

RSpec.describe Weapon, type: :model do
  it "has invalid level" do
  	level = FFaker::Random.rand(100..999)

  	weapon = build(:weapon, level: level)
  	expect(weapon).to_not be_valid
  end

  it "returns the correct title" do
  	weapon = create(:weapon)
  	expect(weapon.title).to eq("#{weapon.name}##{weapon.level}")
  end

  it "verify the power base" do
  	weapon = create(:weapon)

  	expect(weapon.current_power).to eq(weapon.power_base + (weapon.level - 1) * weapon.power_step)
  end
end
