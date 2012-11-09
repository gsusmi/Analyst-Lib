class AnalystLib::Scraper
  attr_accessor :url, :regex

  def self.scrape_url(url)
    scraper = AnalystLib::Scraper.new(url)
    scraper.scrape()
  end

  def initialize(url)
    @url = url
    @regex = 'a'
  end

  def get_url()
    @doc = Nokogiri::HTML(open(@url))
  end

  def scrape
    @doc ||= get_url()
    @doc.search(@regex)
  end
end