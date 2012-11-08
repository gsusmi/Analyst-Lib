class AnalystLib::Scraper
  attr_accessor :url, :content

  def self.scrape_url(url)
    scraper = AnalystLib::Scraper.new(url)
    scraper.scrape()
  end

  def self.scrape_url_example()
    scraper = AnalystLib::Scraper.new('http://beer.friscogrille.com')
    scraper.scrape()
  end

  def initialize(url)
    @url = url
    @css_node = 'a'
  end

  def get_url()
    @doc = Nokogiri::HTML(open(@url))
  end

  def css_node=(node)
    @css_node = node
  end

  def xpath_node=(node)
    @xpath_node = node
  end

  def get_node()
    @css_node || @xpath_node
  end

  def scrape
    @doc ||= get_url()
    @doc.search(get_node())
  end
end