require 'spec_helper'

#
# There are quite a bit of things I could do to clean this up. I have a number of "magic url's" that I pull out
# of nowhere. These could be made constants and reused
#

describe FaviconFinder::PageParser do

  def strip_query(url)
    url_components = url.split('?')
    url_components.pop
    url_components.join
  end

  describe "#initialize" do

    context "failed instantiation" do
      it "gets passed an invalid domain" do
        expect{FaviconFinder::PageParser.new "some/invalid/path"}.to raise_error(Errno::ENOENT)
      end

      it "gets passed a non-existant domain" do
        expect{FaviconFinder::PageParser.new "http://asdlfhasdlhfasdfaseinae.com"}.to raise_error(SocketError)
      end
    end

    context "successful instantiation" do
      it "gets passed a valid domain" do
        expect(FaviconFinder::PageParser.new "http://google.com").to be_instance_of(FaviconFinder::PageParser)
      end

      it "gets passed a domain with a redirect" do
        expect{FaviconFinder::PageParser.new "http://crayon.co"}.not_to raise_error
      end
    end
  end

  describe "#find_favicon_url" do
    it "should return the correct url with shortcut icon rel value" do
      parser = FaviconFinder::PageParser.new "http://www.hubspot.com/"
      fav_url = parser.find_favicon_url
      expect(strip_query(fav_url)).to eq('http://cdn2.hubspot.net/hub/53/file-8149778-png/fav.png')
    end
  end

end
