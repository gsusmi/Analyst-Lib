require 'analyst-lib/text_encoding'

module AnalystLib
  class BeerName
    def self.canonicalize(name)
      name = TextEncoding.encode(name)
      strip_qualifiers(name.tr('()/', ' ')).gsub(/\s+/, ' ').strip
    end

    def self.strip_qualifiers(name)
      name.gsub(/\b(?:N2|nitro)\b/i, '')
    end
  end
end
