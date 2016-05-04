require 'sequel'

module FaviconFinder
  class Favicon < Sequel::Model

    def self.retrieve_and_persist(domain)
      begin
        page_parser = PageParser.new domain
        url = page_parser.find_favicon_url
        if url
          persist(domain, url)
        else
          nil
        end
      rescue Exception => e
        puts e
        nil
      end
    end

    private

    def validate
      super
      errors.add(:name, 'Domain already exists') if domain_exists?
    end

    def self.persist(domain, url)
      favicon = Favicon.new
      favicon.url = domain
      favicon.fav_url = url
      puts "#{domain} saved!"
      begin
        favicon.save
      rescue Sequel::ValidationFailed
        puts "#{domain} failed validation!"
        favicon
      end
    end

    def domain_exists?
      if Favicon[:url => url]
        true
      else
        false
      end
    end

  end
end
