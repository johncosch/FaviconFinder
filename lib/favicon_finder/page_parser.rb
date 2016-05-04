require "nokogiri"
require "open-uri"
require 'open_uri_redirections'
require "httparty"

module FaviconFinder
  class PageParser

    #
    # Note: Invalid domains should be caught on instantiation
    # Note: perhaps I should check the default location prior to parsing
    #

    def initialize(domain)
      @domain = domain
      @doc = Nokogiri::HTML(open(@domain, :allow_redirections => :all))
    end

    def find_favicon_url
      node = parse_page_for_link
      if node && node['href']
        UrlCleaner.clean(node['href'], @domain)
      elsif verify_image_location(default_location)
        default_location
      else
        nil
      end
    end

    private

    def parse_page_for_link
      elements = @doc.xpath "//head/link[translate(
      @rel,
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
      'abcdefghijklmnopqrstuvwxyz'
      ) = 'icon' or translate(
      @rel,
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
      'abcdefghijklmnopqrstuvwxyz'
      ) = 'shortcut icon']"
      elements.first
    end

    def default_location
      File.join(@domain, "favicon.ico")
    end

    def verify_image_location(image_location)
      begin
        response = HTTParty.get(image_location, follow_redirects: true)
        response.code == 200 && response.headers['Content-Type'].start_with?('image')
      rescue Exception => e
        puts "EXCEPTION: #{e} for url : #{image_location}"
      end
    end

  end
end
