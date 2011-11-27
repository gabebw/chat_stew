# Chat Stew

Chat Stew parses Adium logs and serves them up to you in an easy-to-use format.
It allows you to plug in your own parser. See below for more details on writing
your own parser.

## Usage

    require 'chat_stew'
    # my_file can be anything that responds to #read. If it's a String, it's assumed
    # that it's a filename.
    chat = ChatStew.parse(my_file)
    chat.each do |message|
      message.sender
      message.receiver
      message.message
      message.time # a DateTime
    end

## Writing your own parser
A parser is anything that conforms to this specification:

* responds to `#can_parse?(file)` and returns truish or falsish
* responds to `#parse(file)` and returns an Enumerable containing
  `ChatStew::AdiumMessage` instances

If two parsers are registered that can both parse a given file, the
most-recently-registered parser will win. For example: let's say both FooParser
and BarParser can parse a file named "foo.bar". You register FooParser and then
register BarParser. `ChatStew.parse("foo.bar")` will use BarParser since it was
registered after FooParser.

    class FooParser
      def can_parse?(file)
        file.path =~ /foo$/
      end

      def parse(file)
        # Just return an empty log
        []
      end
    end

    # Register it
    foo_parser = FooParser.new
    ChatStew.register(foo_parser)
    # Will use foo_parser, so parse_result will be an empty array.
    parse_result = ChatStew.parse("whatever.foo")

## Author

Gabe Berke-Williams, 2011
