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
      @containing_div.at("div[@class='airdate']").text.strip rescue nil
    end

    def plot
      plot = @containing_div.at("div[@class='item_description']").text.strip rescue nil
      plot.include?('Add a plot') ? nil : plot
    end

    def title
      @containing_div.at("a[@itemprop='name']").text.strip rescue nil
    end

    private

    def document
      @document ||= Nokogiri::HTML open @url
    end

  end
end
