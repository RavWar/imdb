module Imdb
  class TvShow < Base
    extend Imdb::Search

    SEARCH_URL = "http://akas.imdb.com/find?&s=tt&ttype=tv&q=".freeze

    def season(number)
      raise "There are only #{seasons_count} seasons in this tv-show" if number > seasons_count
      Imdb::Season.new @id, season_url(number), number
    end

    def is_a_tvshow?
      document.css("h5[text()='Seasons:']").any?
    end

    def seasons_count
      @seasons_count ||= document.css("a[@href*='episodes?season=']")
      @seasons_count.to_a.delete_if{|el| el.inner_html == 'unknown' }.count
    end

    def season_url(number)
      raise "There are only #{seasons_count} seasons in this tv-show" if number > seasons_count
      @season_url = "http://www.imdb.com/title/tt#{id}/episodes?season=#{number}"
    end
  end
end
