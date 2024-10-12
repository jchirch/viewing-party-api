class MovieGateway
  # def self.movie_details(query)

  # end

  def self.top_rated
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params['api_key'] = Rails.application.credentials.tmdb[:key]
    end
    # require 'pry'; binding.pry
    response = conn.get("/3/movie/top_rated")
    
    if response.success?
      movies = JSON.parse(response.body, symbolize_names: true) #[:results]
      movies.first(20)
    else
      "false"
    end
  end

  def self.search(params)
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      # require 'pry'; binding.pry
      faraday.params['api_key'] = Rails.application.credentials.tmdb[:key]
      # require 'pry'; binding.pry
      faraday.params['query'] = params[:query]
    end
    response = conn.get("/3/search/movie")

    if response.success?
      movies = JSON.parse(response.body, symbolize_names: true)[:data]
    else
      "false"
    end

    # if response.success?
     
    #   movies = JSON.parse(response.body, symbolize_names: true)[:data]
    #   render json: MovieSerializer.format_movie_list(movies.first(20))
   
    # else
    #   render json: {error: "Internal Server Error"}, status: 500
    # end

  end

end