require "rails_helper"

RSpec.describe "Endpoints" do
  describe "View Party Endpoints" do
    it "can create view party with correct attributes" do
      user1 = User.create!(name: "Danny DeVito", username: "danny_de_v", password: "jerseyMikesRox7")
      user2 =User.create!(name: "Dolly Parton", username: "dollyP", password: "Jolene123")
      user3 =User.create!(name: "Lionel Messi", username: "futbol_geek", password: "test123")
      user4 =User.create!(name: "Joe", username: "Joe_username", password: "good123")

      test_params = {
        "name": "Juliet's Bday Movie Bash!",
        "start_time": "2025-02-01 10:00:00",
        "end_time": "2025-02-01 14:30:00",
        "movie_id": 278,
        "movie_title": "The Shawshank Redemption",
        "api_key": "#{user1.api_key}", 
        "invitees": [user2.id, user3.id, user4.id] 
      }

      post "/api/v1/viewing_parties", params: test_params

      expect(response).to be_successful
      expect(response.status).to eq(201)
      party = JSON.parse(response.body, symbolize_names: true)[:data]
      require 'pry'; binding.pry
      expect(party[:id]).to be_a(String)
      expect(party[:type]).to be("viewing_party")
      expect(party[:attributes][:name]).to be_a(String)
      expect(party[:attributes][:start_time]).to be_a(String)
      expect(party[:attributes][:end_time]).to be_a(String)
      expect(party[:attributes][:movie_id]).to be_an(Integer)
      expect(party[:attributes][:movie_title]).to be_a(String)
    end
  end

  describe "sad paths" do
    xit "returns error with invalid api key" do
      user1 = User.create!(name: "Danny DeVito", username: "danny_de_v", password: "jerseyMikesRox7")
      user2 =User.create!(name: "Dolly Parton", username: "dollyP", password: "Jolene123")
      user3 =User.create!(name: "Lionel Messi", username: "futbol_geek", password: "test123")
      user4 =User.create!(name: "Joe", username: "Joe_username", password: "good123")

      test_params = {
        "name": "Juliet's Bday Movie Bash!",
        "start_time": "2025-02-01 10:00:00",
        "end_time": "2025-02-01 14:30:00",
        "movie_id": 278,
        "movie_title": "The Shawshank Redemption",
        "api_key": "0", 
        "invitees": [user2.id, user3.id, user4.id] 
      }

      post "/api/v1/viewing_parties", params: test_params

    end
  end
end
