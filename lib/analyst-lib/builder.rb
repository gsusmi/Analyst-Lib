class AnalystLib::Builder
  attr_accessor :raw_data, :href_regex

  SEARCH_URL = "http://www.google.com/search?q=site:beeradvocate.com+"

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
    url = SEARCH_URL + name.to_s
    url.gsub!(' ', '+')
    scraped_result = scrape(url)

    parsed_result = parse(scraped_result, "cite")

    first_search_result = parsed_result.first

    raise AnalystLib::MetadataNotFound.new(name) unless (first_search_result &&
      first_search_result.children &&
      first_search_result.children.text.match('beeradvocate'))

    beer_link = "http://" + first_search_result.children.text.to_s
    beer_link_result = scrape(beer_link)

    metadata = ::AnalystLib::Metadata.new(beer_link_result)
    metadata.external_link = beer_link
    metadata
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