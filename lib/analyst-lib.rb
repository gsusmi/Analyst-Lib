require 'nokogiri'
require 'open-uri'

class AnalystLib
  def self.process_url(url)
    result = Scraper.scrape_url(url)
    Parser.parse(result)
  end

  def self.fetch_metadata(name)
    uri = URI.escape("http://beeradvocate.com/search?qt=beer&q=" + name.to_s)
    scraper = Scraper.new(uri)
    scraper.regex = "#baContent a"
    result = scraper.scrape()
  end
end

require 'analyst-lib/scraper'
require 'analyst-lib/parser'