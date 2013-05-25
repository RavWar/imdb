module Imdb
  class Episode

    attr_reader :containing_div, :url, :season, :number, :title, :airdate, :plot

    def initialize containing_div, url, season, number
      @containing_div = containing_div
      @url = url
      @season = season
      @number = number
    end

    def airdate
      @containing_div.at("//div[@class='airdate']").inner_html.strip rescue 'not found'
    end

    def plot
      @containing_div.at("//div[@class='item_description']").inner_html.strip rescue 'not found'
    end

    def title
      @containing_div.at("//a[itemprope='name'").inner_html.strip rescue 'not found'
    end

    private

    def document
      @document ||= Nokogiri::HTML open @url
    end

  end
end
