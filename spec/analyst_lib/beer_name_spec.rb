require 'spec_helper'
require 'analyst-lib/beer_name'

describe AnalystLib::BeerName do
  def can(name)
    AnalystLib::BeerName.canonicalize(name)
  end

  it 'will strip unhelpful characters from the name' do
    can('Boulder Obovoid Oak-Aged Stout (N2)').should ==
      'Boulder Obovoid Oak-Aged Stout'

    can('Boulevard/Pretty Things Stingo').should ==
      'Boulevard Pretty Things Stingo'
  end
end
