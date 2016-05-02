require 'sequel'

module FaviconFinder
  class Favicon < Sequel::Model

    def validate
      super
      errors.add(:name, 'Domain already exists') if domain_exists?
    end

    def self.retrieve_and_persist(domain)
      begin
        page_parser = PageParser.new domain
        url = page_parser.find_favicon_url
        persist(domain, url)
      rescue
        nil
      end
    end

    def self.persist(domain, url)
      favicon = Favicon.new
      favicon.url = domain
      favicon.fav_url = url
      begin
        favicon.save
      rescue Sequel::ValidationFailed
        puts "#{domain} failed validation!"
        favicon
      end
    end

    private

    def domain_exists?
      if Favicon[:url => url]
        true
      else
        false
      end
    end

  end
end
