module Imdb
  class Season

    attr_reader :show_id, :ur, :season_number

    def initialize(show_id, url, season_number)
      @show_id = show_id
      @url = url
      @season_number = season_number
    end

    def episodes_count
      @episodes_count ||= document.search("div[@class='list detail eplist']//div[@class*='list_item']").count
    end

    def episode(number)
      raise "There is no #{number} episode in this season" if number > episodes_count
      @episode ||= Imdb::Episode.new(containing_div_for_episode(number), @url, @season_number, number)
    end

    private

    def document
      @document ||= Hpricot(open(@url))
    end

    def containing_div_for_episode(number)
      @containing_div ||= document.search("meta[@itemprop='episodeNumber'][@content='#{number}']/../..div[@class*='list_item'")
    end

  end
end