require 'analyst-lib/text_encoding'

class AnalystLib::Scraper
  def self.scrape_url(url)
    Nokogiri::HTML(AnalystLib::TextEncoding.encode(open(url).read()))
  end
end
