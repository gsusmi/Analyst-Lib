module AnalystLib
  class GoogleResultParser
    def self.parse(html_doc)
      self.new(html_doc).parse
    end

    def initialize(doc)
      @doc = doc
    end

    def parse
      results = @doc.xpath('//*[@class="g"]')
      results.each_with_index.map { |result, i|
        GoogleSearchResult.parse(result, i)
      }
    end
  end

  class GoogleSearchResult
    attr_accessor :title, :url, :rank

    def self.parse(result_node, rank)
      result = self.new
      result.title = result_node.at_css('.r > a').text()
      result.url = result_node.at_css('cite').text()
      result.rank = rank
      result
    end

    def http_url
      "http://#{url}"
    end
  end
end
