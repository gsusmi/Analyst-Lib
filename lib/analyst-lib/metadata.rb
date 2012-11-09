class AnalystLib::Metadata
  attr_accessor :rating_score, :rating_desc, :abv,
    :description, :name
  
  def initialize(metadata)    
    self.metadata = metadata
  end
  
  def metadata=(metadata)
    content = metadata.search('tr')
    @rating_score = content.search('//span[@class="BAscore_big"]').first.text
    @rating_desc = "CANNOT FIND"
    @abv = content.search('td')[1].text.match(/\d{1}.\d{2}% ABV/)[0].split('%')[0]
    @description = "CANNOT FIND"
  end
end