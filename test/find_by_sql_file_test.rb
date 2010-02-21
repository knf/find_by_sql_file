require File.dirname(__FILE__) + '/test_helper'

class Article < ActiveRecord::Base
end

class FindBySqlFileTest < Test::Unit::TestCase

  def test_counting_by_sql_file
    assert_equal Article.count_by_sql(:count_all), Article.count
  end

  def test_find_all
    assert_equal Article.find_by_sql(:all), Article.find(:all)
  end

  def test_find_last_updated
    assert_equal Article.find_one_by_sql(:last_updated),
                 Article.find(:first, :order => 'updated_at DESC')
  end

  def test_named_bind_variables
    assert_equal Article.find_by_sql(:with_variables,
                   :published  => @articles.last.published,
                   :created_on => @articles.last.created_on),
                 Article.find(:all, :conditions => {
                   :published  => @articles.last.published,
                   :created_on => @articles.last.created_on })
  end

  def test_erb_injection
    fields = 'id, title, published'

    assert_equal(
      Article.find_by_sql(:with_erb_fields,
        :inject! => { :select => fields }).map  { |a| a.attributes },
      Article.find(:all, :select => fields).map { |a| a.attributes } )
  end

  def test_query_reformatting
    assert_equal 'SELECT * FROM articles ORDER BY updated_at DESC LIMIT 1',
                 Article.sql_file(:last_updated)
  end

  def setup
    @articles = []

    @articles << Article.new(:title      => 'Lorem ipsum dolor sit amet',
                             :published  => true,
                             :created_on => '1969-01-27',
                             :updated_at => '2008-10-06 12:02:32')

    @articles << Article.new(:title      => 'Consectetur adipisicing elit',
                             :published  => false,
                             :created_on => '1969-12-30',
                             :updated_at => '2008-10-06 12:02:32')

    @articles << Article.new(:title      => 'Sed do eiusmod tempor incididunt',
                             :published  => false,
                             :created_on => '1969-01-15',
                             :updated_at => '2008-10-06 12:02:32')

    @articles << Article.new(:title      => 'Ut enim ad minim veniam',
                             :published  => false,
                             :created_on => '1999-12-13',
                             :updated_at => '2012-10-06 12:02:32')

    @articles.each { |a| a.save }
  end

  def teardown
    Article.delete_all
  end
end