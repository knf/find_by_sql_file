require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the find_by_sql_file plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the find_by_sql_file plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'FindBySqlFile'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

namespace :rcov do
  begin
    require 'rcov/rcovtask'
  rescue LoadError
    desc '(Not installed!)'
    task :build do
      puts "Install 'rcov' to get test coverage reports."
    end
  else
    Rcov::RcovTask.new(:build) do |t|
      t.test_files = %w[ test/*_test.rb ]
      t.output_dir = 'coverage'
      t.verbose    = true
      t.rcov_opts  << '-x /Library -x ~/.gem -x /usr --html'
    end
  end
end

task :rcov => :'rcov:build'