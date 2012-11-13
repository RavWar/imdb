module Imdb
  class Season

    def initialize(parent_id, url)
      @parent_id = parent_id
      @url = url
    end

    def epidoes_count
      document.search("div[@class='list detail eplist']//div[@class*='list_item']").count
    end

    def document
      @document ||= Hpricot(open(@url))
    end

  end
end