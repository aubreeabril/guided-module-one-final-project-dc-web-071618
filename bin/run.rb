require_relative '../config/environment'

puts "Hey there"

ActiveRecord::Base.logger.level = 1

new_cli = CommandLine.new
new_cli.greet
