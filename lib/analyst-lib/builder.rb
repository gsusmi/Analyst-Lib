class AnalystLib::Builder
  attr_accessor :raw_data, :href_regex

  METADATA_URL = "http://beeradvocate.com"
  SEARCH_URL = "http://beeradvocate.com/search?qt=beer&q="

  def self.build_list(url)
    scraped_result = scrape(url)
    parsed_result = parse(scraped_result, "a")

    # TODO: Configure matcher for name
    list = parsed_result.map do |node|
      if(node["href"] && node["href"].match(/beer/))
        node.inner_text
      end
    end

    list.compact!
  end

  def self.build_metadata(name)
    scraped_result = scrape(SEARCH_URL + name.to_s)
    parsed_result = parse(scraped_result, "#baContent a")

    first_search_result = parsed_result.first
    raise AnalystLib::MetadataNotFound.new(name) unless (first_search_result &&
      first_search_result[:href] &&
      first_search_result[:href].match('/beer/profile'))
    
    beer_link = first_search_result[:href]
    beer_link_result = scrape(METADATA_URL + beer_link.to_s)
    
    ::AnalystLib::Metadata.new(beer_link_result)
  end
  
  private
    def self.scrape(url)
      ::AnalystLib::Scraper.scrape_url(url)
    end
  
    def self.parse(raw_data, search_tag)
      parser = ::AnalystLib::Parser.new(raw_data)
      parser.search_tag = search_tag
      parser.parse()
    end
end