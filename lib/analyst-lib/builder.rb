require 'open-uri'
require 'analyst-lib/beer_advocate_metadata_lookup'
require 'analyst-lib/beer_name'
require 'analyst-lib/beer_advocate_search'

class AnalystLib::Builder
  attr_accessor :raw_data, :href_regex

  SEARCH_URL = "http://www.google.com/search?q=site:beeradvocate.com+"

  def self.build_list(url)
    list = {:drafts => [], :bottles => []}
    scraped_result = scrape(url, 'ISO-8859-1')

    draft_parsed_result = parse(scraped_result, "//div[@id='drafts']").search('a')
    bottles_parsed_result = parse(scraped_result, "//div[@id='bottles']").search('a')

    # TODO: Configure matcher for name
    list[:drafts] = map_result(draft_parsed_result, "href", /beer/).compact!
    list[:bottles] = map_result(bottles_parsed_result, "href", /beer/).compact!

    list
  end

  def self.build_metadata(raw_name)
    name = AnalystLib::BeerName.canonicalize(raw_name)

    search_result = AnalystLib::BeerAdvocateSearch.search(name)
    raise AnalystLib::MetadataNotFound.new(name) unless search_result

    AnalystLib::BeerAdvocateMetadataLookup.lookup_metadata(search_result)
  rescue OpenURI::HTTPError
    raise AnalystLib::MetadataNotFound.new(name)
  end

  private
    def self.map_result(result, node_attribute, node_regex)
      result.map do |node|
        if(node[node_attribute] && node[node_attribute].match(node_regex))
          node.inner_text
        end
      end
    end

    def self.scrape(url, content_encoding='UTF-8')
      ::AnalystLib::Scraper.scrape_url(url, content_encoding)
    end

    def self.parse(raw_data, search_tag)
      parser = ::AnalystLib::Parser.new(raw_data)
      parser.search_tag = search_tag
      parser.parse()
    end
end
