require "rails_helper"
require './app/poros/movie_details' 

RSpec.describe MovieDetails do
  let(:shawshank) do
    {
      id: 278,
      title: "The Shawshank Redemption",
      release_date: "1994-09-23",
      runtime: 142,
      genres: [{ name: "Drama" }],
      overview: "I have no idea what this movie is about.",
      vote_count: 124356
    }
  end

  describe "existence" do
    it "exists with attributes" do
      stub_request(:get, "https://api.themoviedb.org/3/movie/278/credits?api_key=#{Rails.application.credentials.tmdb[:key]}")
      .to_return(status: 200, body: { cast: [] }.to_json, headers: { 'Content-Type' => 'application/json' })

      stub_request(:get, "https://api.themoviedb.org/3/movie/278/reviews?api_key=#{Rails.application.credentials.tmdb[:key]}")
      .to_return(status: 200, body: { results: [] }.to_json, headers: { 'Content-Type' => 'application/json' })

      movie = MovieDetails.new(shawshank)

      expect(movie).to be_an_instance_of(MovieDetails)
      expect(movie.id).to eq(278)
      expect(movie.title).to eq("The Shawshank Redemption")
      expect(movie.release_year).to eq("1994")
      expect(movie.runtime).to eq("2 hours, 22 minutes")
      expect(movie.genres).to eq(["Drama"])
      expect(movie.description).to eq("I have no idea what this movie is about.")
      expect(movie.cast).to eq([])
      expect(movie.review_count).to eq(124356)
      expect(movie.reviews).to eq([])
    end
  end

  describe "methods" do
    it "converts integer to runtime" do
      movie_id = 278  

      stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=#{Rails.application.credentials.tmdb[:key]}")
        .to_return(status: 200, body: { cast: [] }.to_json, headers: { 'Content-Type' => 'application/json' })
    
      stub_request(:get, "https://api.themoviedb.org/3/movie/#{movie_id}/reviews?api_key=#{Rails.application.credentials.tmdb[:key]}")
        .to_return(status: 200, body: { results: [] }.to_json, headers: { 'Content-Type' => 'application/json' })
    
      movie_data = {
        id: movie_id,
        title: "A Big Movie",
        release_date: "2024-10-13", 
        vote_average: 8.5,
        runtime: 263,
        genres: [
          { name: "Action" },
          { name: "Adventure" }
        ],
        description: "It was a normal day until it wasn't.",
        cast: ["John Doe", "Jane Doe"],
        review_count: 5,
        reviews: ["Great!", "Good!"]
      }
    
      new_movie = MovieDetails.new(movie_data)
    
      runtime_in_minutes = movie_data[:runtime]
      expect(new_movie.to_hours(runtime_in_minutes)).to eq("4 hours, 23 minutes") 
    end

    xit "converts integer to runtime" do
      stub_request(:get, "https://api.themoviedb.org/3/movie/278/credits?api_key=#{Rails.application.credentials.tmdb[:key]}")
      .to_return(status: 200, body: { cast: [] }.to_json, headers: { 'Content-Type' => 'application/json' })

      stub_request(:get, "https://api.themoviedb.org/3/movie/278/reviews?api_key=#{Rails.application.credentials.tmdb[:key]}")
      .to_return(status: 200, body: { results: [] }.to_json, headers: { 'Content-Type' => 'application/json' })

      movie_data = data = {
        id: 123,
        title: "A Big Movie",
        release_date: "2024-10-13", 
        vote_average: 8.5,
        runtime: 263,
        genres: [
          { name: "Action" },
          { name: "Adventure" }
        ],
        description: "It was a normal day until it wasn't.",
        cast: ["John Doe", "Jane Doe"],
        review_count: 5,
        reviews: ["Great!", "Good!"]
      }

      new_movie = MovieDetails.new(movie_data)
      runtime_in_minutes = 263
      expect(new_movie.to_hours(runtime_in_minutes)).to eq("4 hours, 23 minutes")
    end
  end
end