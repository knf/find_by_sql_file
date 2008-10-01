require 'bunster/find_by_sql_file'

class << ActiveRecord::Base
  include Bunster::FindBySqlFile

  alias_method_chain :find_by_sql,  :sql_file
  alias_method_chain :count_by_sql, :sql_file
end

