class AnalystLib::Scraper
  def self.scrape_url(url)
    Nokogiri::HTML(open(URI.escape(url)))
  end
end