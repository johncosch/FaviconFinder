require "nokogiri"
require "open-uri"
require 'open_uri_redirections'

module FaviconFinder
  class PageParser

    #
    # Invalid domains should be caught on instantiation
    #

    def initialize(domain)
      @domain = domain
      @doc = Nokogiri::HTML(open(@domain, :allow_redirections => :all))
    end

    def find_favicon_url
      elements = @doc.xpath "//head/link[translate(
      @rel,
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
      'abcdefghijklmnopqrstuvwxyz'
      ) = 'icon' or translate(
      @rel,
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
      'abcdefghijklmnopqrstuvwxyz'
      ) = 'shortcut icon']" # old xpath -> "//head/link[@rel = 'icon' or @rel = 'shortcut icon']"
      node = elements.first
      if node && node['href']
        UrlCleaner.clean(node['href'], @domain)
      else
        puts "no node with icon or shortcut icon was found #{@domain}"
        nil
      end
    end

  end
end
