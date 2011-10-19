# Chat Stew
A pluggable parsing library for chat logs. It handles Adium out of the box.

## Usage

    require 'chat_stew'
    # my_file can be anything that responds to #read. If it's a String, it's assumed
    # that it's a filename.
    chat = ChatStew.parse(my_file)
    chat.each do |line|
      line.sender
      line.receiver
      line.message
      line.time # a DateTime
    end

## Writing your own parser
A parser is anything that conforms to this specification:

* responds to #can_parse?(file) and returns truish or falsish
* responds to #parse(file) and returns an Enumerable containing AdiumMessage
  instances

If two parsers are registered that can both parse a given file, the
most-recently-registered parser will win. I.E. if you register FooParser and
then register BarParser, and they can both parse a file called "foo.bar", then
BarParser will be used to parse it since it was registered after FooParser.

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
    # Will use foo_parser, so result will be an empty ChatLog.
    result = ChatStew.parse("whatever.foo")

## Author
Gabe Berke-Williams, 2011
