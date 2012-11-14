module Imdb
  class Season

    attr_reader :parent_id, :ur, :season_number

    def initialize(parent_id, url, season_number)
      @parent_id = parent_id
      @url = url
      @season_number = season_number
    end

    def episodes_count
      @episodes_count ||= document.search("div[@class='list detail eplist']//div[@class*='list_item']").count
    end

    def document
      @document ||= Hpricot(open(@url))
    end

    def episode(number)
      Imdb::Episode.new(@url, @season_number, number)
    end

  end
end