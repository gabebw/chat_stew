require "chat_stew/version"
require "chat_stew/adium_message"
require "chat_stew/parsers/adium"

module ChatStew
  def self.register(parser)
    parsers.unshift(parser)
  end

  def self.parse(input)
    input = StringIO.new(input) unless input.respond_to?(:read)

    valid_parser = parsers.detect {|parser| parser.can_parse?(input) }
    if valid_parser.nil?
      nil
    else
      valid_parser.parse(input)
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
