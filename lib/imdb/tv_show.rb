module Imdb
  class TvShow < Movie

    def initialize(imdb_id, title = nil, also_known_as = [])
      super(imdb_id, title, also_known_as)
      # seasons_count.downto(1) do |n|
      #   self.class.send(:attr_accessor, "season_#{n}")
      #   self.send("season_#{n}=", Imdb::Season.new(imdb_id, "#{season_url(n)}", n))
      # end
    end

    def season(number)
      raise "There are only #{seasons_count} seasons in this tv-show" if number > seasons_count
      Imdb::Season.new(@id, season_url(number), number)
    end

    def is_a_tvshow?
      document.search("h5[text()='Seasons:']").any?
    end

    def seasons_count
      @seasons_count ||= document.search("a[@href*='episodes?season=]")
      @seasons_count.delete_if {|el| el.inner_html == 'unknown' }.count
    end

    def season_url(number)
      raise "There are only #{seasons_count} seasons in this tv-show" if number > seasons_count
      @season_url = "http://www.imdb.com/title/tt#{id}/episodes?season=#{number}"
    end

  end
end