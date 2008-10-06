require 'yaml'
require 'rubygems'
require 'active_record'

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
