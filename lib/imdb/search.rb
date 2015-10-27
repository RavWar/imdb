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
      parse_movies Nokogiri::HTML Imdb.fetch "http://imdb.com/chart/top"
    end

    private

    def parse_movie(doc)
      id    = doc.at("head/link[@rel='canonical']")['href'][/\d+/]
      title = doc.at("h1").text

      [new(id, title)]
    end

    def parse_movies(doc)
      doc.search(".titleColumn a, .result_text a").map do |element|
        id = element['href'][/\d+/]
        title = element.text
        title = title.split(/\saka\s/).shift.strip

        [id, title]
      end.uniq.map do |values|
        new(*values)
      end
    end
  end
end
