module AnalystLib
  class SearchResultRanker
    def self.rank_results(search_term, results)
      self.new(search_term, results).rank
    end

    def initialize(search_term, results)
      @term = search_term
      @term_keys = @term.split(' ').map(&:downcase)
      @results = results
    end

    def rank
      @results.sort { |a, b|
        relevance_score(b) <=> relevance_score(a)
      }
    end

  private
    # A numeric score for the result increasing by the number of terms
    # in the result that match terms in the search
    def relevance_score(result)
      @term_keys.find_all { |key| result.title =~ /\b#{Regexp.quote(key)}\b/i }.size
    end
  end
end
