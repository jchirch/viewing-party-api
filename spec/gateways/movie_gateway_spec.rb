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

    it "#find_movie" do
      WebMock.allow_net_connect!
      shawshank_id = 278
      result = MovieGateway.find_movie(shawshank_id)

      expect(result[:id]).to eq(278)
      expect(result[:title]).to eq("The Shawshank Redemption")
      expect(result[:vote_average]).to be_a(Float)
      expect(result[:runtime]).to be_a(Integer)
      expect(result[:genres]).to be_an(Array)
      expect(result[:overview]).to be_a(String)
    end

    it "#find_cast" do
      WebMock.allow_net_connect!
      shawshank_id = 278
      cast = MovieGateway.find_cast(shawshank_id)

      expect(cast.length).to be <= 10
      cast.each do |cast_member|
        expect(cast_member).to have_key(:actor)
        expect(cast_member).to have_key(:character)
      end
    end

    it "#find_reviews" do
      WebMock.allow_net_connect!
      shawshank_id = 278
      reviews = MovieGateway.find_reviews(shawshank_id)
      expect(reviews.length).to be <=5

      reviews.each do |review|
        expect(review).to have_key(:author)
        expect(review).to have_key(:review)
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
  
    it "#find_movie returns nil with invalid movie ID" do
      fake_id = 0
      bootleg = MovieGateway.find_movie(fake_id)

      expect(bootleg).to be_nil
    end

    it "#find_cast returns nil with invalid movie ID" do
      fake_id = 0
      bootleg = MovieGateway.find_cast(fake_id)

      expect(bootleg).to be_nil
    end

    it "#find_reviews returns nil with invalid movie ID" do
      fake_id = 0
      bootleg = MovieGateway.find_reviews(fake_id)

      expect(bootleg).to be_nil
    end
  end 
end