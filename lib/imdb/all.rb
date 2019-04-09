module Imdb
  class All < Base
    extend Imdb::Search

    SEARCH_URL = "http://akas.imdb.com/find?&s=all&q=".freeze
  end
end
