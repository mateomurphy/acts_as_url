ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..'

require 'test/unit'
require 'yaml'
#require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb'))

# require 'rubygems'
# require 'active_support'
# require 'active_support/test_case'
require 'active_record'
require File.dirname(__FILE__) + '/../init'



def load_schema
  config = {adapter: 'sqlite3', database: ":memory:" }
  ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
  ActiveRecord::Base.establish_connection(config)
  load(File.dirname(__FILE__) + "/schema.rb")
  require File.dirname(__FILE__) + '/../init.rb'
end
