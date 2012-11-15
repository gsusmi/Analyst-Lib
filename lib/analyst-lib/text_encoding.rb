module AnalystLib
  class TextEncoding
    # Get rigorous with encoding
    def self.encode(text, output='UTF-8')
      text.encode(output, invalid: :replace, undef: :replace)
    end
  end
end
