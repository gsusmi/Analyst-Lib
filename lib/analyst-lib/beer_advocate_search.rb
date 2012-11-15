require 'cgi'
require 'analyst-lib/google_result_parser'
require 'analyst-lib/search_result_ranker'

module AnalystLib
  class BeerAdvocateSearch
    SEARCH_URL = "http://www.google.com/search?q=site:beeradvocate.com+"

    def self.search(beer_name)
      self.new(beer_name).search
    end

    def initialize(beer_name)
      @beer_name = beer_name
    end

    def search
      document = Scraper.scrape_url(self.search_url)
      results = GoogleResultParser.parse(document).find_all { |result|
        result.url =~ /beeradvocate.*beer.profile/i
      }
      SearchResultRanker.rank_results(@beer_name, results).first

    rescue OpenURI::HTTPError
      raise AnalystLib::MetadataNotFound.new(@beer_name)
    end

    def search_url
      @search_url ||= (SEARCH_URL + url_escape(@beer_name))
    end

  private
    def url_escape(string)
      CGI.escape(string)
    end
  end
end
