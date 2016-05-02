$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
ENV['RACK_ENV'] = 'test'

require 'sequel'
require 'database_cleaner'

DB = Sequel.connect('postgres://johncosch@localhost/favicon_finder_test')
DatabaseCleaner[:sequel, {:connection => DB}]
Sequel::Model.plugin :timestamps, :create => :created_at

require 'favicon_finder'
require 'rack/test'

module RSpecMixin
  include Rack::Test::Methods
  def app() FaviconFinder::Api end
end

RSpec.configure do |config|

  config.include RSpecMixin

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
