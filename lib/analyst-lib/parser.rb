class AnalystLib::Parser
  def self.parse(scraped_result)
    parsed_result = []

    scraped_result.each do |result|
      if(result[:href] && result[:href].match('beer_details'))
        parsed_result << result.inner_text
      end
    end

    parsed_result
  end
end