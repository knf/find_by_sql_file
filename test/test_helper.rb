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

def load_fixtures!
  Article.create :title      => 'Lorem ipsum dolor sit amet',
                 :published  => true,
                 :created_on => '1969-01-27',
                 :updated_at => '2008-10-06 12:02:32'

  Article.create :title      => 'Consectetur adipisicing elit',
                 :published  => false,
                 :created_on => '1969-12-30',
                 :updated_at => '2008-10-06 12:02:32'

  Article.create :title      => 'Sed do eiusmod tempor incididunt',
                 :published  => false,
                 :created_on => '1969-01-15',
                 :updated_at => '2008-10-06 12:02:32'

  Article.create :title      => 'Ut enim ad minim veniam',
                 :published  => false,
                 :created_on => '1999-12-13',
                 :updated_at => Time.now
end

class Article < ActiveRecord::Base
end

establish_connection!
create_tables!
load_fixtures!
RAILS_ROOT = File.join( File.dirname(__FILE__), 'mock_rails_root' )
require File.join(File.dirname(__FILE__), '..', 'lib', 'find_by_sql_file')
