class MovieSerializer
  include JSONAPI::Serializer
  attributes :title, :vote_average

  def self.format_movie_list(movies)
    {data:
      movies.map do |movie|
        {
          id: movie[:id],
          type: 'movie',
          attributes: {
            title: movie[:original_title],
            vote_average: movie[:vote_average]
          }
        }
      end
  }
  end
end

# data: movies.take(20).map do |movie|