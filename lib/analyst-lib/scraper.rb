require 'analyst-lib/text_encoding'

class AnalystLib::Scraper
  def self.scrape_url(url, content_encoding=nil)
    text = open(url).read()
    text = text.force_encoding(content_encoding) if content_encoding
    Nokogiri::HTML(AnalystLib::TextEncoding.encode(open(url).read()))
  end
end
