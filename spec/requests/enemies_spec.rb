require 'rails_helper'
require 'json'

RSpec.describe "Enemies", type: :request do
   describe "GET /enemies" do
	   	before(:all) do
	   		@enemies = FactoryBot.create_list(:enemy, 3)
	   		get enemies_path
	   	end

	   	it "returns status code 200" do
	   		expect(response).to have_http_status(200)
	   	end

	   	it "returns all enemies" do
	   		json_response = JSON.parse(response.body)
	   		
	   		@enemies.each do |enemy|
	   			expect(json_response).to include(enemy.as_json)
	   		end
	   	end
   end

   describe "GET /enemies/:id" do
   		before(:all) do
   			@enemy = create(:enemy)
   			get "/enemies/#{@enemy.id}"
   		end

   		it "returns status code 200" do
   			expect(response).to have_http_status(200)
   		end

   		it "returns the enemy" do
   			json_response = JSON.parse(response.body)
   			expect(json_response).to include(@enemy.as_json)
   		end
   end

   # describe "POST /enemies" do
   # 		it "create the enemy and returns the enemy created" do
   # 			enemy_attributes = FactoryBot.attributes_for(:enemy)
   # 			post enemies_path, params: {enemy: enemy_attributes}

   # 			expect(Enemy.last).to have_attributes(enemy_attributes)
   # 		end
   # end

   describe "PUT /enemy/:id" do
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

   describe "DELETE /enemies" do
   		context "when the enemy exists" do
   			before(:all) do
   				@enemy = create(:enemy)
   				delete "/enemies/#{@enemy.id}"
   			end

   			it "returns status code 204" do
   				expect(response).to have_http_status(204)
   			end

   			it "destroy the record" do
   				expect {@enemy.reload}.to raise_error ActiveRecord::RecordNotFound
   			end
   		end

   		context "when the enemy does not exists" do
   			before(:all) do
   				delete "/enemies/0"
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
