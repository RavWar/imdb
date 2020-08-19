module Imdb
  class Movie < Base
    extend Imdb::Search

    # Used akas due to query param escaping difference on imdb side
    SEARCH_URL = "https://imdb.com/find?&s=tt&ttype=ft&q=".freeze
  end
end
