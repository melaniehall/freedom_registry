require "rubygems"
require "bundler/setup"
require "active_record"
require 'rspec'
require 'database_cleaner'
require './models/organization'

def establish_connection
  connection_details = YAML::load(File.open('config/database.yml'))
  ActiveRecord::Base.establish_connection(connection_details['test'])
end

def migrate_test_database
  ActiveRecord::Migrator.migrate("db/migrate/")
end

RSpec.configure do |c|
  c.before(:suite) { establish_connection }
  # c.before(:suite) { migrate_test_database }
  # c.before(:suite) { DatabaseCleaner.strategy = :transaction }
  # c.before(:suite) { DatabaseCleaner.clean_with(:truncation) }

  c.before(:each) do
    # DatabaseCleaner.start
  end

  c.after(:each) do
    # DatabaseCleaner.clean
  end
end