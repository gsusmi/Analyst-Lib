require 'spec_helper'
require 'analyst-lib/google_result_parser'
require 'nokogiri'

describe AnalystLib::GoogleResultParser do
  SUPPORT_FILE = 'spec/support/google-result.html'

  def parse(dom)
    AnalystLib::GoogleResultParser.parse(dom)
  end

  def doc(name)
    Nokogiri::HTML(File.read(name))
  end

  let (:html) {
    doc(SUPPORT_FILE)
  }

  let (:accented_html) {
    doc('spec/support/ayinger-brau-weisse.html')
  }

  it 'will parse HTML into search results' do
    results = parse(html)
    results.size.should == 10

    results.first.title.should == 'Laughing Dog Brewing - Ponderay, ID - Beers - BeerAdvocate'
    results.first.url.should == 'beeradvocate.com/beer/profile/12985'

    results[1].title.should == 'Hop Dog Harvest Pale Ale - Laughing Dog Brewing - Ponderay, ID ...'
    results[1].url.should == 'beeradvocate.com/beer/profile/12985/39122'
  end

  it 'will search for accented characters' do
    results = parse(accented_html)
    results.size.should == 10
  end
end
