require 'erb'
require 'active_record'

module FindBySqlFile
  # This makes it a tad simpler to create a clean ERB binding context. It
  # works like so:
  #
  # ERBJacket.wrap "A Foo is: <%= @foo -%>", :foo => 'not a bar'
  #
  class ERBJacket
    def initialize(hash) # :nodoc:
      hash.each { |k, v| instance_variable_set('@' + k.to_s, v) }
    end

    def wrap(erb_template) # :nodoc:
      ::ERB.new(erb_template, nil, '-').result binding
    end

    def self.wrap(erb_template = '', instance_variables = {}) # :nodoc:
      new(instance_variables).wrap erb_template
    end
  end

  def find_by_sql_with_sql_file(query_or_symbol, opts = {}) # :nodoc:
    find_by_sql_without_sql_file sql_file(query_or_symbol, opts)
  end

  def count_by_sql_with_sql_file(query_or_symbol, opts = {}) # :nodoc:
    count_by_sql_without_sql_file sql_file(query_or_symbol, opts)
  end

  def sql_file(query_or_symbol, opts = {}) # :nodoc:
    if query_or_symbol.is_a? Symbol

      file_name = Rails.root.join 'app', 'queries',
        (table_name rescue 'application'), (query_or_symbol.to_s + '.sql')

      # bound_variables = HashWithIndifferentAccess.new(opts).symbolize_keys!
      # injected_locals = bound_variables.delete(:inject!) || []

      query = ERBJacket.wrap File.read(file_name), injected_locals
      # query = replace_named_bind_variables(query, bound_variables)

      query.gsub(/-- .*/, '').strip.gsub(/\s+/, ' ')
    else
      raise 'Additional parameters only supported when using a query' \
            ' file (pass a symbol, not a string)' unless opts.blank?

      query_or_symbol
    end
  end

  # The equivalent of ActiveRecord::Base#find_by_sql(*args).first
  def find_one_by_sql(*args)
    find_by_sql(*args).first
  end
end

class << ActiveRecord::Base
  include FindBySqlFile

  alias_method_chain :find_by_sql,  :sql_file
  alias_method_chain :count_by_sql, :sql_file
end