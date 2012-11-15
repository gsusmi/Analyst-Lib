require 'spec_helper'
require 'analyst-lib/search_result_ranker'
require 'ostruct'

describe AnalystLib::SearchResultRanker do
  def result(title)
    OpenStruct.new(title: title)
  end

  it 'will rank results by relevance' do
    results = [
      result('How now brown cow'),
      result('Where does the rain fall in Spain'),
      result('The road to Gandolfo'),
      result('The road to Gandolfo and beyond')
    ]
    AnalystLib::SearchResultRanker.rank_results("beyond Gandolfo", results)[0...2].should == [
      result('The road to Gandolfo and beyond'),
      result('The road to Gandolfo')
    ]
  end
end
