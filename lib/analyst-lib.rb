require 'nokogiri'
require 'open-uri'

class AnalystLib
  def self.process_url(url)
    result = Scraper.scrape_url(url)
    Parser.parse(result)
  end
end

require 'analyst-lib/scraper'
require 'analyst-lib/parser'