$:.push File.expand_path("../lib", __FILE__)

require "version"

Gem::Specification.new do |s|
  s.name        = "analyst-lib"
  s.version     = AnalystLib::VERSION
  s.authors     = ["Susmitha Girumala"]
  s.email       = ["gsusmi@gmail.com.com"]
  s.homepage    = "http://23pages.com"
  s.summary     = "Gem to support scraping and metadata fetch."
  s.description = "Blah de blah"

  s.files = Dir["{lib}/**/*"] + ["README.md"]
end
