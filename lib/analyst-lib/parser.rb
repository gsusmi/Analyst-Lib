class AnalystLib::Parser
  attr_accessor :raw_data, :href_regex

  def self.parse(scraped_result)
    parser = AnalystLib::Parser.new(scraped_result)
    parser.parse_data()
  end

  def initialize(raw_data)
    @raw_data = raw_data
    @href_regex = 'beer_details'
  end

  def parse_data()
    data = []

    @raw_data.each do |result|
      if(result[:href] && result[:href].match(@href_regex))
        data << result.inner_text
      end
    end

    data
  end
end