Gem::Specification.new do |s|
  s.name        = 'find_by_sql_file'
  s.version     = '0.9.3'
  s.date        = '2008-10-03'

  s.author      = 'Jordi Bunster'
  s.email       = 'jordi@bunster.org'
  s.homepage    = 'http://github.com/jordi/find_by_sql_file'

  s.summary     = "Extension to ActiveRecord's find_by_sql to use SQL files"
  s.description = %{ This ActiveRecord extension lets you pass a symbol to
                     ActiveRecord::Base#find_by_sql, which refers to a query
                     file saved under app/queries/. Variable replacement
                     and ERB are available, and comments and indentation are
                     stripped. }.strip!.gsub! /\s+/, ' '

  s.test_files  = %w[ test test/find_by_sql_file_test.rb ]
  s.files       = %w[ MIT-LICENSE
                      README.markdown
                      Rakefile
                      find_by_sql_file.gemspec
                      init.rb
                      install.rb
                      lib
                      lib/bunster
                      lib/bunster/erb_jacket.rb
                      lib/bunster/find_by_sql_file.rb
                      lib/find_by_sql_file.rb
                      lib/jordi-find_by_sql_file.rb
                      rails
                      rails/init.rb ]

  s.has_rdoc         = true
  s.extra_rdoc_files = %w[ README.markdown        ]
  s.rdoc_options     = %w[ --main README.markdown ]
end