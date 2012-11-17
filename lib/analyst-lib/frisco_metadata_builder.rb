module AnalystLib
  class FriscoMetadataBuilder
    def self.build(dom)
      self.new(dom).build
    end

    def initialize(dom)
      @dom = dom
    end

    def build
      meta = AnalystLib::Metadata.new
      meta.abv = self.abv
      meta
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
