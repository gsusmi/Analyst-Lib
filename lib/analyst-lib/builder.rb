require 'open-uri'
require 'analyst-lib/beer_advocate_metadata_lookup'
require 'analyst-lib/beer_name'
require 'analyst-lib/beer_advocate_search'

class AnalystLib::Builder
  attr_accessor :raw_data, :href_regex

  SEARCH_URL = "http://www.google.com/search?q=site:beeradvocate.com+"
  FRISCO_METADATA_URL = 'http://beer.friscogrille.com'

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

    if search_result.nil?
      puts "fetching frisco metadata"
      metadata = frisco_metadata(raw_name)
    else
      beer_advocate_metadata = AnalystLib::BeerAdvocateMetadataLookup.lookup_metadata(search_result)

      if(beer_advocate_metadata.abv.nil?)
        frisco_metadata = frisco_metadata(raw_name)
        beer_advocate_metadata.abv = frisco_metadata.abv if frisco_metadata
      end

      metadata = beer_advocate_metadata
    end

    metadata
  rescue OpenURI::HTTPError => e
    frisco_metadata(raw_name)
  end

  private
    def self.frisco_metadata(name)
      scraped_result = scrape(FRISCO_METADATA_URL)
      parsed_scraped_result = parse(scraped_result, "//a")

      metadata_map = Hash[parsed_scraped_result.map {|x| [x.text, "#{FRISCO_METADATA_URL}#{x[:href]}"]}]
      metadata_url = metadata_map.fetch(name)

      scraped_result = scrape(metadata_map.fetch(name))
      AnalystLib::FriscoMetadataBuilder.build(scraped_result)
    rescue KeyError
    end

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
