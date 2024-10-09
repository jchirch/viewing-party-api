require "rails_helper"

RSpec.describe "Movie Endpoints" do
  describe "happy path" do
    xit "can retrieve top 20 highest rated movies FROM API" do
      get '/api/v1/movies/top_rated'

      expect(response).to be_successful

      movies = JSON.parse(response.body, symbolize_names: true)[:data]
          require 'pry'; binding.pry
      movies.each do |movie|
        expect(movie).to have_key(:id)
        expect(movie[:type]).to eq('movie')
        expect(movie[:attributes]).to have_key(:title)
        expect(movie[:attributes]).to have_key(:vote_average)
      end
      expect(movies.length).to eq(20)
    end

    it "can retrieve top 20 movies MOCK" do
      json_response = File.read('spec/fixtures/top_20.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{Rails.application.credentials.tmdb[:key]}").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.10.1'
           }).
         to_return(status: 200, body: json_response, headers: {})

         get '/api/v1/movies/top_rated'

      expect(response).to be_successful

      movies = JSON.parse(response.body, symbolize_names: true)[:data]
       
      movies.each do |movie|
        expect(movie).to have_key(:id)
        expect(movie[:type]).to eq('movie')
        expect(movie[:attributes]).to have_key(:title)
        expect(movie[:attributes]).to have_key(:vote_average)
      end
      expect(movies.length).to eq(20)
    end
  end

  describe "sad path" do
    it "returns error message from failed response" do
      json_response = File.read('spec/fixtures/top_20.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{Rails.application.credentials.tmdb[:key]}").
         with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.10.1'
          }).
         to_return(status: 500, body: "test", headers: {})

         get '/api/v1/movies/top_rated'
        
        expect(response.status).to eq(500)
        error_response = JSON.parse(response.body, symbolize_names: true)
        expect(error_response[:error]).to eq("Internal Server Error")
    end
  end
end