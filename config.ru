$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'sequel'

connection_string = 'postgres://johncosch@localhost/favicon_finder_development'
DB = Sequel.connect(ENV["DATABASE_URL"] || connection_string)
Sequel::Model.plugin :timestamps, :create => :created_at

require 'favicon_finder'

run FaviconFinder::Api
