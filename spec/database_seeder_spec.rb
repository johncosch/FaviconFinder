require 'spec_helper'
require 'ruby-prof'

describe FaviconFinder::DatabaseSeeder do

  describe ".seed" do
    it "seeds the db" do
      FaviconFinder::DatabaseSeeder.seed
      domain = DB[:favicons][:url => "http://cnn.com"]
      expect(domain).to eq("http://cnn.com")
    end
  end

end
