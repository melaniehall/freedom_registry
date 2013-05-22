#!/usr/bin/env ruby
# -*- ruby -*-
require 'rake'
require 'rspec/core/rake_task'
require_relative 'bootstrap_ar'

RSpec::Core::RakeTask.new(:spec)

task :default  => :spec


require 'active_record'
require 'yaml'

db_namespace = namespace :db do
  desc "Migrate the db"
  task :migrate do
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details['development'])
    ActiveRecord::Migrator.migrate("db/migrate/")
    db_namespace["schema:dump"].invoke
  end
  desc 'Rolls the schema back to the previous version (specify steps w/ STEP=n).'
  task :rollback do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1
    ActiveRecord::Migrator.rollback(ActiveRecord::Migrator.migrations_paths, step)
    db_namespace["schema:dump"].invoke
  end

  namespace :schema do
    desc 'Create a db/schema.rb file that can be portably used against any DB supported by AR'
    task :dump do
      require 'active_record/schema_dumper'
      connection_details = YAML::load(File.open('config/database.yml'))
      ActiveRecord::Base.establish_connection(connection_details['development'])
      filename = ENV['SCHEMA'] || "db/schema.rb"
      File.open(filename, "w:utf-8") do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
      end
    end
  end

  require 'csv'
  desc "Import csv to db"
  task :seed do
    connection_details = YAML::load(File.open('config/database.yml'))
    ActiveRecord::Base.establish_connection(connection_details['development'])
    ActiveRecord::Migrator.migrate("db/migrate/")

    CSV.foreach("./fr_organizations.csv") do |row|
    # CSV.read("../fr_organizations.csv").each do |row|
      Organization.create(
        :id => row[0],
        :name => row[1],
        :mission_statement => row[2],
        :address_line1 => row[3],
        :address_line2 => row[4],
        :city => row[5],
        :state => row[6],
        :zip => row[7],
        :country => row[8],
        :mailing_address_line1 => row[9],
        :mailing_address_line2 => row[10],
        :mailing_city => row[11],
        :mailing_state => row[12],
        :mailing_zip => row[13],
        :mailing_country => row[14],
        :contact_name => row[15],
        :contact_email => row[16],
        :contact_phone => row[17],
        :website => row[18],
        :facebook => row[19],
        :twitter => row[20],
        :youtube => row[21],
        :blog => row[22],
        :year_founded => row[23],
        :organization_type_id => row[32],
        :irs_sub_section_code => row[33],
        :registered_with_state => row[75]
        )
    end
  end
end

