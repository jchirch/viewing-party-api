class Api::V1::MoviesController < ApplicationController

  def index
    # require 'pry'; binding.pry
    path = request.path
    if path == "/api/v1/movies/top_rated"
      result = MovieGateway.top_rated

      if result == "false"
        render json: {error: "Internal Server Error"}, status: 500
      else
        render json: MovieSerializer.format_movie_list(result)       
      end
    elsif path == "/api/v1/search/movie"
      result = MovieGateway.search(params)

      if result == "false"
        render json: {error: "Internal Server Error"}, status: 500
      else
        render json: MovieSerializer.format_movie_list(result)       
      end
    end

    # if params = query, search
    # elsif top_rated
    # else movies.all
    # end

  end
  # request.path = "/api/v1/movies/top_rated"

  # def top_rated
  #   conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
  #     faraday.params['api_key'] = Rails.application.credentials.tmdb[:key]
  #   end
  #   response = conn.get("/3/movie/top_rated")

  #   if response.success?
  #     movies = JSON.parse(response.body, symbolize_names: true) #[:results]
  #     top_20 = movies.first(20)
  #     render json: MovieSerializer.format_movie_list(top_20) 
  #   else
  #     render json: {error: "Internal Server Error"}, status: 500
  #   end
  # end

  # take logic above, turn into gateway method
  # call top_rated in index action
  #
  #

  
end

# bad form, but useful
# response = Faraday.get("https://api.themoviedb.org/3/movie/top_rated?api_key=b954b8c88874a2bb37ce96a4aa2a3551")
