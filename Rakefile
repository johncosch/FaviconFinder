$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'sequel'
require 'database_cleaner'
connection_string = 'postgres://johncosch@localhost/favicon_finder_development'
DB = Sequel.connect(ENV["DATABASE_URL"] || connection_string)
Sequel::Model.plugin :timestamps, :create => :created_at

require 'favicon_finder'

namespace :db do
  task :clean do
    DatabaseCleaner[:sequel, {:connection => DB}]
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end

  task :seed do
    seeder = FaviconFinder::DatabaseSeeder.new
    seeder.seed
  end
end
