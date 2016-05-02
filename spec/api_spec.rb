require 'spec_helper'

describe FaviconFinder::Api do
  let(:domain){"http://hubspot.com"}
  let(:url){"http://cdn2.hubspot.net/hub/53/file-8149778-png/fav.png"}

  def strip_query(url)
    url_components = url.split('?')
    url_components.pop
    url_components.join
  end

  describe "#get_favicon_for_url" do

    context "is fresh" do
      it "retrieves the favicon" do
        api = FaviconFinder::Api.new!
        record = api.get_favicon_for_url(domain, true)
        expect(strip_query(record[:fav_url])).to eq(url)
      end
    end

    context "not fresh" do
      it "does not have an existing record" do
        api = FaviconFinder::Api.new!
        record = api.get_favicon_for_url(domain, false)
        expect(strip_query(record[:fav_url])).to eq(url)
      end

      it "does have an existing record" do
        FaviconFinder::Favicon.insert(:url => domain, :fav_url => url)
        api = FaviconFinder::Api.new!
        record = api.get_favicon_for_url(domain, false)
        expect(record[:fav_url]).to eq(url)
      end
    end
  end

end
