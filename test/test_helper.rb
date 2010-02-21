require 'test/unit'
require 'yaml'
require 'pathname'
require 'rubygems'
require 'active_record'

begin
  require 'leftright'
rescue LoadError
  puts "Install the 'leftright' gem (optional) to get awesome test output"
end

module Rails
  def self.root
    Pathname.new File.join(File.dirname(__FILE__), 'rails_root_fixture')
  end
end

ActiveRecord::Base.establish_connection :adapter  => 'sqlite3',
                                        :database => ':memory:'

ActiveRecord::Schema.define :version => 1 do
  create_table :articles, :force => true do |article|
    article.string    :title
    article.boolean   :published
    article.date      :created_on
    article.timestamp :updated_at
  end
end

require 'find_by_sql_file'