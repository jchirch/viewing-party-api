class MovieDetails
  attr_reader :id,
              :title,
              :release_year, 
              :vote_average, 
              :runtime,
              :genres,
              :description,
              :cast,
              :review_count,
              :reviews
  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @release_year = data[:release_date].split('-').first
    @runtime = to_hours(data[:runtime])
    @genres = data[:genres].map { |genre| genre[:name] }
    @description = data[:overview]
    @cast = find_cast(data[:id])
    @review_count = data[:vote_count]
    @reviews = find_reviews(data[:id]) 
  end

  def to_hours(runtime)
    hours = runtime / 60
    minutes = runtime % 60
    return "#{hours} hours, #{minutes} minutes"
  end

  def find_cast(movie_id)
    MovieGateway.find_cast(movie_id)
  end

  def find_reviews(movie_id)
    MovieGateway.find_reviews(movie_id)
  end
end