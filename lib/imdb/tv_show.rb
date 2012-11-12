module Imdb
  class TvShow < Movie

    def initialize(imdb_id, title = nil, also_known_as = [])
      super(imdb_id, title, also_known_as)
      seasons_count.downto(1) do |n|
        self.class.__send__(:attr_accessor, "load_season_#{n}")
        self.__send__("load_season_#{n}=", OpenStruct.new)
      end
    end

    def is_a_tvshow?
      document.search("h5[text()='Seasons:']").any?
    end

    def seasons_count
      @seasons_count ||= document.search("a[@href*='episodes?season=]").count
    end

    def season_url(season_number)
      raise "There are only #{@seasons_count} seasons in this tv-show" if season_number > seasons_count
      @season_url = "http://www.imdb.com/title/tt#{id}/episodes?season=#{season_number}"
    end

    private

    def method_missing(method_name, *args, &block)
      if method_name.to_s =~ /^season_(\d{1,2})/
        season_url($1.to_i)
      else
        super
      end
    end

  end
end