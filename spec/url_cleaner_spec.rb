require 'spec_helper'

describe FaviconFinder::UrlCleaner do

  describe ".absolute_url?" do

    it "handles http urls" do
      expect(FaviconFinder::UrlCleaner.absolute_url?("http://favicon.com")).to be_truthy
    end

    it "handles https urls" do
      expect(FaviconFinder::UrlCleaner.absolute_url?("https://favicon.com")).to be_truthy
    end

    it "handles relative urls" do
      expect(FaviconFinder::UrlCleaner.absolute_url?("favicon.com")).to be_falsey
    end
  end

  describe ".full_url" do
    let(:domain) {"https://crayon.co"}

    it "handles an absolute url" do
      expect(FaviconFinder::UrlCleaner.full_url("https://crayon.co/favicon.ico", domain)).to eq("https://crayon.co/favicon.ico")
    end

    it "handles a relative url" do
      expect(FaviconFinder::UrlCleaner.full_url("favicon.ico", domain)).to eq("https://crayon.co/favicon.ico")
    end
  end

end
