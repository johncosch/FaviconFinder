require 'spec_helper'
require 'ruby-prof'

describe FaviconFinder::DatabaseSeeder do

=begin

  # This spec takes a long time to run and should not be run with the rest of the suite

  describe ".seed" do
    it "seeds the db" do
      seeder = FaviconFinder::DatabaseSeeder.new
      seeder.seed
      domain = DB[:favicons][:url => "http://cnn.com"]
      expect(domain).to eq("http://cnn.com")
    end
  end

=end

end
