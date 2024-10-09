require "rails_helper"

RSpec.describe "Movie Endpoints" do
  describe "happy path" do
    xit "can retrieve top 20 highest rated movies FROM API" do
      get '/api/v1/movies/top_rated'

      expect(response).to be_successful

      movies = JSON.parse(response.body, symbolize_names: true)[:data]
        # require 'pry'; binding.pry
        expect(movies.length).to eq(20)

    end

  
  end
end