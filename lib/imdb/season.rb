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

    def episode_info(episode_number)
      Imdb::Episode.new(@season_number, episode_number,  episode_title(episode_number), episode_airdate(episode_number),
        episode_plot(episode_number))
    end

    def episode_airdate(episode_number)
      raise "There are only #{episodes_count} episodes in this season" if episode_number > episodes_count
      containing_div(episode_number).search("//div[@class='airdate']")
        .inner_html
        .strip.imdb_unescape_html rescue 'not found'
    end

    def episode_plot(episode_number)
      containing_div(episode_number).search("//div[@class='item_description']").inner_html.strip
    end

    def episode_title(episode_number)
      containing_div(episode_number).search("//a[itemprope='name'").inner_html.strip rescue 'not found'
    end

    private

    def containing_div(episode_number)
      document.search("meta[@itemprop='episodeNumber'][@content='#{episode_number}']/../..div[@class*='list_item'")
    end

  end
end