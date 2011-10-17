$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH << File.join(File.dirname(__FILE__))

require 'rspec'
require 'bourne'

require 'chat_stew'

RSpec.configure do |c|
  c.mock_with :mocha
end
