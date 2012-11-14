module Imdb
  class Episode

    attr_reader :url, :season, :number, :title, :airdate, :plot

    def initialize(url, season, number)
      @url = url
      @season = season
      @number = number
    end

    def airdate
      containing_div.search("//div[@class='airdate']")
        .inner_html
        .strip.imdb_unescape_html rescue 'not found'
    end

    def plot
      containing_div.search("//div[@class='item_description']").inner_html.strip rescue 'not found'
    end

    def title
      containing_div.search("//a[itemprope='name'").inner_html.strip rescue 'not found'
    end

    private

    def document
      Hpricot(open(@url))
    end

    def containing_div
      document.search("meta[@itemprop='episodeNumber'][@content='#{@number}']/../..div[@class*='list_item'")
    end

  end
end