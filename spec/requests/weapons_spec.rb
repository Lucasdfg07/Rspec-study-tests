require 'rails_helper'


RSpec.describe "Weapons", type: :request do
	describe "GET /weapons" do
		before(:all) do
			@weapons = FactoryBot.create_list(:weapon, 3)
			get weapons_path
		end

		it "has success status" do
			expect(response).to have_http_status(200)
		end	

		it "show the name" do
			@weapons.each do |weapon|
				expect(response.body).to include(weapon.name)
			end
		end

		it "show the current power" do
			@weapons.each do |weapon|
				expect(response.body).to include(weapon.current_power.to_s)
			end
		end

		it "show the title" do
			@weapons.each do |weapon|
				expect(response.body).to include(weapon.title)
			end
		end

		it "show the link to weapon" do
			@weapons.each do |weapon|
				expect(response.body).to include(weapon_path(weapon))
			end
		end
	end

	describe "POST /weapons" do
		it "has correct params" do
			weapon_attributes = FactoryBot.attributes_for(:weapon)
			post weapons_path, params: {weapon: weapon_attributes}

			expect(Weapon.last).to have_attributes(weapon_attributes)
		end

		it "has not correct params" do
			expect{
				post weapons_path, params: {weapon: {name: '', description: '', level: ''}}
			}.to_not change(Weapon, :count)
		end
	end

	describe "DELETE /weapon/:id" do
		it "verify if ID is present and is being deleted" do
			weapons = FactoryBot.create_list(:weapon, 3)

			weapons.each do |weapon|
				get weapon_path(weapon)
				expect(response).to have_http_status(200)

				delete weapon_path(weapon)
			end
		end
	end

	describe "GET /weapon/:id" do
		it "verify if all details are present" do
			weapons = FactoryBot.create_list(:weapon, 3)

			weapons.each do |weapon|
				get weapon_path(weapon)
				expect(response.body).to include(weapon.name, 
												 weapon.description,
												 weapon.level.to_s,
												 weapon.power_base.to_s,
												 weapon.power_step.to_s,
												 weapon.current_power.to_s,
												 weapon.title)
			end
		end
	end
end