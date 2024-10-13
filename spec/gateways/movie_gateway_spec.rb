require "rails_helper"

RSpec.describe MovieGateway do
  describe "happy paths" do
    it "returns top rated movies with successful API call" do
      json_response = File.read('spec/fixtures/top_20.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{Rails.application.credentials.tmdb[:key]}")
        .to_return(status: 200, body: json_response)
      result = MovieGateway.top_rated

      expect(result.length).to eq(20)

      result.each do |movie|
        expect(movie).to have_key(:id)
        expect(movie[:attributes]).to have_key(:title)
        expect(movie[:attributes]).to have_key(:vote_average)
      end
    end

    it "returns movie based on search params with successful API call" do
      json_response = File.read('spec/fixtures/movie_search.json')
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&query=God").

      to_return(status: 200, body: json_response, headers: {})
      results = MovieGateway.search("God")

      expect(results).to be_an(Array)
      
      results.each do |movie|
        expect(movie[:title]).to include("God")
      end
    end
  end

  describe "sad paths" do
    it "returns nil from failed API call" do
      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{Rails.application.credentials.tmdb[:key]}")
        .to_return(status: 500)
      result = MovieGateway.top_rated
      expect(result).to be(nil)
    end

    it "returns nil from failed API called search" do
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?api_key=#{Rails.application.credentials.tmdb[:key]}&query=God")
        .to_return(status: 500)
      result = MovieGateway.search("God")
      expect(result).to be(nil)
    end
  end
  it "returns movie object with descriptions" do
    
  end
end