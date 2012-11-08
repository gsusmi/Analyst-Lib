require 'nokogiri'
require 'open-uri'

class AnalystLib
  def self.scrape(url)
    result = Scraper.scrape_url(url)
    Parser.parse(result)
  end

  def self.scrape_example()
    result = Scraper.scrape_url_example()
    Parser.parse(result)
  end
end

require 'analyst-lib/scraper'
require 'analyst-lib/parser'