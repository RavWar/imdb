module Imdb
  class TvShow < Base
    extend Imdb::Search

    SEARCH_URL = "https://imdb.com/find?&s=tt&ttype=tv&q=".freeze

    def season(number)
      raise "There are only #{seasons_count} seasons in this tv-show" if number > seasons_count
      Imdb::Season.new @id, season_url(number), number
    end

    def is_a_tvshow?
      document.css("h5[text()='Seasons:']").any?
    end

    def seasons_count
      @seasons_count ||= document.css("a[@href*='episodes?season=']").first.text.to_i rescue nil
    end

    def season_url(number)
      raise "There are only #{seasons_count} seasons in this tv-show" if number > seasons_count
      @season_url = "https://imdb.com/title/tt#{id}/episodes?season=#{number}"
    end
  end
end
