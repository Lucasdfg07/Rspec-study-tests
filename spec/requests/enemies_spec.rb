require 'rails_helper'

RSpec.describe "Enemies", type: :request do
  describe "PUT /enemies" do
    context "when the enemy exists" do
    	before(:all) do
    		@enemy = create(:enemy)

    		@enemy_attributes = attributes_for(:enemy)
    		put "/enemies/#{@enemy.id}", params: @enemy_attributes
    	end

    	it "returns status code 200" do
    		expect(response).to have_http_status(200)
    	end

    	it "updates record" do
    		expect(@enemy.reload).to have_attributes(@enemy_attributes)
    	end

    	it "returns the enemy updated" do
    		json_response = JSON.parse(response.body)
    		expect(@enemy.reload).to have_attributes(json_response.except('created_at', 'updated_at'))
    	end
    end

    context "when the enemy does not exists" do
    	before(:all) do
    		put '/enemies/0', params: attributes_for(:enemy)
    	end

    	it "returns status code 404" do
    		expect(response).to have_http_status(404)
    	end

    	it "returns NOT_FOUND message" do
    		expect(response.body).to match(/Couldn't find Enemy/)
    	end
    end
  end
end
