require 'nokogiri'
require 'open-uri'

class AnalystLib
  def self.beer_list(url)
    Builder.build_list(url)
  end

  def self.beer_metadata(name)
    Builder.build_metadata(name)
  end
end

require 'analyst-lib/scraper'
require 'analyst-lib/parser'
require 'analyst-lib/builder'
require 'analyst-lib/metadata'
require 'analyst-lib/errors'