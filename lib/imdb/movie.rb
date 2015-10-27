module Imdb
  class Movie < Base
    extend Imdb::Search

    # Use akas due to query param escaping difference on imdb side
    SEARCH_URL = "http://akas.imdb.com/find?&s=tt&ttype=ft&q=".freeze
  end
end
