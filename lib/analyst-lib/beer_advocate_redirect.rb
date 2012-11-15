require 'uri'

module AnalystLib
  class BeerAdvocateRedirect
    def self.redirect_url(url, doc)
      ba_content = doc.at_css('div#baContent')
      text = ba_content.text()
      if text =~ /This beer is an alias for/
        result_url = resolve_url(url, ba_content.at_css('a').attr('href'))
        return result_url unless result_url == url
      end
    end

    def self.resolve_url(url, relative)
      URI.join(url, relative || '')
    end
  end
end
