class AnalystLib::Parser
  attr_accessor :raw_data, :search_tag

  def initialize(raw_data)
    @raw_data = raw_data
    @search_tag = 'a'
  end

  def parse()
    @raw_data.search(@search_tag)
  end
end