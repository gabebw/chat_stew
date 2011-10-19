$LOAD_PATH << File.join(File.dirname(__FILE__))
$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require "rspec"
require "bourne"

require "chat_stew"

require "./spec/support/mock_parser"

RSpec.configure do |c|
  c.mock_with :mocha
end
