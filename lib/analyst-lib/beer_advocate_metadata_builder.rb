require 'analyst-lib/metadata'

module AnalystLib
  class BeerAdvocateMetadataBuilder
    def self.build(dom)
      self.new(dom).build
    end

    def initialize(dom)
      @dom = dom
    end

    def build
      meta = AnalystLib::Metadata.new
      meta.rating_score = self.rating_score
      meta.abv = self.abv
      meta.type = self.type
      meta.external_link = self.external_link
      meta
    end

    def rating_score
      node = content.search('//span[@class="BAscore_big"]').first
      node && node.text
    end

    def abv
      td = content.search('td')[1]
      return nil unless td

      text = td.text
      if text && text =~ /(\d+(?:[.]\d+)?)% ABV/
        $1.to_f
      end
    end

    def external_link
      tag = content.search("//a[@class='twitter-share-button']")
      tag && tag.first && tag.first["data-url"]
    end

    def type
      style = content.at_xpath("//a[contains(@href, 'beer/style')][1]")
      style && style.text
    end

    def content
      @content ||= @dom.search('tr')
    end
  end
end
