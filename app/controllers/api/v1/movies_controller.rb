class Api::V1::MoviesController < ApplicationController

  def index
    path = request.path
    if path == "/api/v1/movies/top_rated"
      sort_response(MovieGateway.top_rated)
    elsif path == "/api/v1/search/movie"
      sort_response(MovieGateway.search(params[:query]))
    else
      render json: {error: "Internal Server Error"}, status: 500
    end
  end

  def show
    movie_id = params[:id]
    if movie_id == nil
      render json: {error: "Movie not found"}, status: 404
    else
      render json: MovieDetails.new(MovieGateway.find_movie(movie_id))
    end
  end

  private

  def sort_response(result)
    if result == nil
      render json: {error: "Internal Server Error"}, status: 500
    else
      render json: MovieSerializer.format_movie_list(result)
    end
  end
end