Gem::Specification.new do |s|
  s.name        = 'find_by_sql_file'
  s.version     = '0.9.9'
  s.date        = '2010-2-21'

  s.author      = 'Jordi Bunster'
  s.email       = 'jordi@bunster.org'
  s.homepage    = 'http://github.com/jordi/find_by_sql_file'

  s.summary     = "Extension to ActiveRecord's find_by_sql to use SQL files"
  s.description = %{ This ActiveRecord extension lets you pass a symbol to
                     ActiveRecord::Base#find_by_sql, which refers to a query
                     file saved under app/queries/. Variable replacement
                     and ERB are available, and comments and indentation are
                     stripped. }.strip!.gsub! /\s+/, ' '

  s.test_files  = %w[
    test
    test/find_by_sql_file_test.rb
    test/rails_root_fixture
    test/rails_root_fixture/app
    test/rails_root_fixture/app/queries
    test/rails_root_fixture/app/queries/articles
    test/rails_root_fixture/app/queries/articles/all.sql
    test/rails_root_fixture/app/queries/articles/count_all.sql
    test/rails_root_fixture/app/queries/articles/last_updated.sql
    test/rails_root_fixture/app/queries/articles/with_erb_fields.sql
    test/rails_root_fixture/app/queries/articles/with_variables.sql
    test/test_helper.rb
  ]

  s.files = %w[ MIT-LICENSE
                README.rdoc
                Rakefile
                WHATSNEW
                find_by_sql_file.gemspec
                lib
                lib/find_by_sql_file.rb
                rails
                rails/init.rb ]

  s.has_rdoc         = true
  s.extra_rdoc_files = %w[ README.rdoc        ]
  s.rdoc_options     = %w[ --main README.rdoc ]
end