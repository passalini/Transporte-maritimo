require 'active_record'
require 'yaml'
require 'logger'
require 'sqlite3'

task :migrate => :environment do
  ActiveRecord::Migrator.migrate('db/migrate',
    ENV['VERSION'] ? ENV['VERSION'].to_i : nil)
end

task :rollback => :environment do
  ActiveRecord::Migrator.rollback('db/migrate',
    ENV['STEP'] ? ENV['STEP'].to_i : 1)
end

task :environment do
  ActiveRecord::Base.establish_connection(
    YAML::load(File.open('./config/database.yml')))
  ActiveRecord::Base.logger = Logger.new(File.open('./log/database.log', 'a'))
end

