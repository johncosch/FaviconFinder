module FaviconFinder
  class UrlCleaner

    def self.clean_domain(domain)
      domain = domain.gsub(/\s+/, "")
      components = domain.split(":")
      if components[0] == "http" || components[0] == "https"
        domain
      else
        "http://" + domain
      end
    end

    def self.clean(url, domain)
      url = full_url(url, domain)
      full_protocol(url, domain)
    end

    private

    def self.full_protocol(url, domain)
      has_relative_protocol?(url) ? add_relative_protocol(url, domain) : url
    end

    def self.full_url(url, domain)
      absolute_url?(url) ? url : File.join(domain, url)
    end

    def self.absolute_url?(url)
      /^(?:[a-z]+:)?\/\// =~ url
    end

    def self.add_relative_protocol(url, domain)
      url_components = domain.split("/")
      url_components[0] + url
    end

    def self.has_relative_protocol?(url)
      /^\/\// =~ url
    end

  end
end
