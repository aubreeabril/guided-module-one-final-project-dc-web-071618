require 'rainbow/refinement'
require 'bundler'
# require_relative '../'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

# ActiveRecord::Base.logger.level = 1
ActiveRecord::Base.logger = nil
