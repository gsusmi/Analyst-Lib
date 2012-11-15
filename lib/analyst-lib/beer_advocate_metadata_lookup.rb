require 'analyst-lib/beer_advocate_redirect'
require 'analyst-lib/beer_advocate_metadata_builder'

module AnalystLib
  class BeerAdvocateMetadataLookup
    def self.lookup_metadata(beer)
      self.new(beer).lookup
    end

    def initialize(beer)
      @beer = beer
    end

    def lookup
      url = @beer.http_url
      3.times {
        beer_link_result = Scraper.scrape_url(url)
        url = self.redirect_url(url, beer_link_result)
        return AnalystLib::BeerAdvocateMetadataBuilder.build(beer_link_result) unless url
      }
    end

    def redirect_url(url, doc)
      BeerAdvocateRedirect.redirect_url(url, doc)
    end
  end
end
