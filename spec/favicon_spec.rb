require 'spec_helper'

describe FaviconFinder::Favicon do

  let(:domain){"http://hubspot.com"}
  let(:url){"http://cdn2.hubspot.net/hub/53/file-8149778-png/fav.png"}

  describe "validation" do
    context "The domain already exists" do
      it "is invalid" do
        FaviconFinder::Favicon.insert(:url => domain, :fav_url => url)
        favicon = FaviconFinder::Favicon.new
        favicon.url = domain
        favicon.fav_url = url
        expect{favicon.save}.to raise_error(Sequel::ValidationFailed)
      end
    end

    context "the domain is unique" do
      it "is valid" do
        favicon = FaviconFinder::Favicon.new
        favicon.url = domain
        favicon.fav_url = url
        expect{favicon.save}.not_to raise_error
      end
    end
  end
end
