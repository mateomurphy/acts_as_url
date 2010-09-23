require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the acts_as_url plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the acts_as_url plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ActsAsUrl'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "acts_as_url"
    gemspec.summary = "This acts_as extension adds the protocol to a url"
    gemspec.description = "This acts_as extension adds the protocol (eg http) to a url database column if missing. It also validates the url against a regular expression."
    gemspec.email = "molte93@gmail.com"
    gemspec.authors = ["Molte Emil Strange Andersen"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end