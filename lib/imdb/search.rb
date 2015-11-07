module Imdb
  module Search
    def search(query)
      doc = Nokogiri::HTML Imdb.fetch "#{self::SEARCH_URL}#{CGI::escape(query)}"

      # Exact match
      if doc.at("table[@id='title-overview-widget-layout']")
        parse_movie(doc)
      else
        parse_movies(doc)
      end
    end

    def top250
      parse_movies Nokogiri::HTML Imdb.fetch "http://www.imdb.com/chart/top"
    end

    private

    def parse_movie(doc)
      id = doc.at("head/link[@rel='canonical']")['href'][/\d+/]
      [new(id)]
    end

    def parse_movies(doc)
      doc.search(".titleColumn a, .result_text a").map do |element|
        element['href'][/\d+/] # ID
      end.uniq.map do |values|
        new(*values)
      end
    end
  end
end
