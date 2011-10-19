require "chat_stew/version"
require "chat_stew/adium_message"
require "chat_stew/parsers/adium"

module ChatStew
  def self.register(parser)
    parsers.unshift(parser)
  end

  def self.parse(file)
    valid_parser = parsers.detect {|parser| parser.can_parse?(file) }
    if valid_parser.nil?
      nil
    else
      valid_parser.parse(file)
    end
  end

  def self.clear_parsers!
    @parsers = []
  end

  private

  def self.parsers
    @parsers ||= []
  end
end
