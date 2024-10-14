require "rails_helper"
# require './app/poros/movie_details.rb'

RSpec.describe "Movie Details" do
  describe "existance" do
    it "exists with attributes" do



    end
  end

  describe "methods" do
    xit "converts integer to runtime" do
      new_movie = MovieDetails.new({})
      runtime_in_minutes = 263
      expect(new_movie.to_hours(runtime_in_minutes)).to eq("4 hours, 23 minutes")
    end
  end

end