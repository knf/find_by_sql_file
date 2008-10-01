module Bunster # :nodoc:
  module FindBySqlFile

    # The path to the directory query queries will be found, organized
    # inside directories named like their main tables (or 'application'
    # for shared queries)
    SQL_PATH = File.join RAILS_ROOT, 'app', 'queries'

    def find_by_sql_with_sql_file(query_or_symbol, opts = {}) # :nodoc:
      find_by_sql_without_sql_file sql_file(query_or_symbol, opts)
    end

    def count_by_sql_with_sql_file(query_or_symbol, opts = {}) # :nodoc:
      count_by_sql_without_sql_file sql_file(query_or_symbol, opts)
    end

    def sql_file(query_or_symbol, opts = {}) # :nodoc:
      if query_or_symbol.is_a? Symbol

        file_name = File.join SQL_PATH,
          (table_name rescue 'application'), (query_or_symbol.to_s + '.sql')

        bound_variables = HashWithIndifferentAccess.new(opts).symbolize_keys!
        injected_locals = bound_variables.delete(:inject!) || []

        query = ERBJacket.wrap File.read(file_name), injected_locals
        query = replace_named_bind_variables(query, bound_variables)

        query.gsub(/--.*/, '').squish!
      else
        raise %' Additional parameters only supported when using a query
          file (pass a symbol, not a string) '.squish! unless opts.blank?

        query_or_symbol
      end
    end
  end
end
