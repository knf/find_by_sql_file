require 'rubygems'
require 'test/unit'
require 'active_record'
require 'yaml'

begin
  require 'leftright'
rescue LoadError
  puts "Install the 'leftright' gem to get awesome test output"
end

def establish_connection!
  database_config_file   = File.join File.dirname(__FILE__), 'database.yml'
  database_configuration = YAML::load File.open(database_config_file)

  ActiveRecord::Base.establish_connection database_configuration
end

def create_tables!
  load File.join( File.dirname(__FILE__), 'schema.rb' )
end

class Article < ActiveRecord::Base
end

establish_connection!
create_tables!
RAILS_ROOT = File.join( File.dirname(__FILE__), 'mock_rails_root' )
require File.join(File.dirname(__FILE__), '..', 'lib', 'find_by_sql_file')
