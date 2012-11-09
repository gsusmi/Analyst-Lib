class AnalystLib::Builder
  attr_accessor :raw_data, :href_regex

  METADATA_URL = "http://beeradvocate.com"
  SEARCH_URL = "http://beeradvocate.com/search?qt=beer&q="

  def self.build_list(url)
    list = {:drafts => [], :bottles => []}
    scraped_result = scrape(url)

    draft_parsed_result = parse(scraped_result, "//div[@id='drafts']").search('a')
    bottles_parsed_result = parse(scraped_result, "//div[@id='bottles']").search('a')

    # TODO: Configure matcher for name
    list[:drafts] = map_result(draft_parsed_result, "href", /beer/).compact!
    list[:bottles] = map_result(bottles_parsed_result, "href", /beer/).compact!

    list
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
    def self.map_result(result, node_attribute, node_regex)
      result.map do |node|
        if(node[node_attribute] && node[node_attribute].match(node_regex))
          node.inner_text
        end
      end
    end

    def self.scrape(url)
      ::AnalystLib::Scraper.scrape_url(url)
    end

    def self.parse(raw_data, search_tag)
      parser = ::AnalystLib::Parser.new(raw_data)
      parser.search_tag = search_tag
      parser.parse()
    end
end