module AnalystLib
  class FriscoMetadataBuilder
    def self.build(dom, metadata)
      self.new(dom, metadata).build
    end

    def initialize(dom, metadata)
      @dom = dom
      @metadata = metadata
    end

    def build
      @metadata.abv = self.abv
      @metadata
    end

    def abv
      element = content.search("[text()*='ABV:']")[0].next
      return nil unless element

      text = element.text
      text.gsub('%', '')
      text.strip.to_f
    end

    def content
      @content ||= @dom.search("//div[@data-role='content']")
    end
  end
end
