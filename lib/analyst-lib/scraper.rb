class AnalystLib::Scraper
  def self.scrape_url(url)
    Nokogiri::HTML(open(url))
  end
end
