class MovieGateway

  def self.top_rated
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params['api_key'] = Rails.application.credentials.tmdb[:key]
    end
    response = conn.get("/3/movie/top_rated")

    return nil unless response.success?
    movies = JSON.parse(response.body, symbolize_names: true).first(20) #[:results]
  end

  def self.search(params)
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params['api_key'] = Rails.application.credentials.tmdb[:key]
      faraday.params['query'] = params
    end
    response = conn.get("/3/search/movie")

    return nil unless response.success?
    movies = JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.find_movie(movie_id)
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params['api_key'] = Rails.application.credentials.tmdb[:key]
    end
    response = conn.get("/3/movie/#{movie_id}")

    return nil unless response.success?
    movie = JSON.parse(response.body, symbolize_names: true)
  end

  def self.find_cast(movie_id)
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params['api_key'] = Rails.application.credentials.tmdb[:key]
    end
    response = conn.get("/3/movie/#{movie_id}/credits")
    return nil unless response.success?
    JSON.parse(response.body, symbolize_names: true)[:cast].first(10).map do |cast_unit|
      {
        actor: cast_unit[:name],
        character: cast_unit[:character]
      }
    end
  end

  def self.find_reviews(movie_id)
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params['api_key'] = Rails.application.credentials.tmdb[:key]
    end
    response = conn.get("/3/movie/#{movie_id}/reviews")
    return nil unless response.success?

    JSON.parse(response.body, symbolize_names: true)[:results].first(5).map do |review|
      {
        author: review[:author],
        review: review[:content]
      }
    end
  end
end