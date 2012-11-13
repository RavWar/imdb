module Imdb
  class Episode

    attr_reader :season, :number, :title, :airdate, :plot

    def initialize(season, number, title, airdate, plot)
      @season = season
      @number = number
      @title = title
      @airdate = airdate
      @plot = plot
    end

  end
end