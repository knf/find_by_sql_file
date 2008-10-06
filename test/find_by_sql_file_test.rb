require 'test/unit'
require File.join(File.dirname(__FILE__), 'test_helper')

class FindBySqlFileTest < Test::Unit::TestCase

  # Replace this with your real tests.
  def test_this_plugin
    Article.find_by_sql :all
  end
end
