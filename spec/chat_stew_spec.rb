require "spec_helper"

describe ChatStew, ".register" do
  let(:parser) { stub("Parser", :can_parse? => true, :parse => []) }
  let(:log)    { stub("Chat Log", :read => "asdf") }

  before { ChatStew.clear_parsers! }

  it "registers the given parser" do
    ChatStew.register(parser)
    ChatStew.parse(log)

    parser.should have_received(:parse).with(log)
  end
end

describe ChatStew, ".parse" do
  let(:parser_one)     { stub("Parser", :can_parse? => true, :parse => ['one']) }
  let(:parser_two)     { stub("Parser", :can_parse? => true, :parse => ['two']) }
  let(:invalid_parser) { stub("Parser", :can_parse? => false, :parse => ['two']) }
  let(:log)            { stub("Adium Log", :read => "asdf") }

  before { ChatStew.clear_parsers! }

  it "only uses parsers that can parse the file" do
    ChatStew.register(parser_one)
    ChatStew.register(invalid_parser)
    ChatStew.parse(log)

    invalid_parser.should have_received(:parse).never
    parser_one.should have_received(:parse).with(log)
  end

  it "parses with the most-recently-registered parser" do
    ChatStew.register(parser_one)
    ChatStew.register(parser_two)
    ChatStew.parse(log)

    parser_one.should have_received(:parse).never
    parser_two.should have_received(:parse).with(log)
  end

  it "returns nil if no parser is available" do
    ChatStew.parse(log).should be_nil
  end
end

describe ChatStew, ".clear_parsers!" do
  let(:parser) { stub("Parser", :can_parse? => true, :parse => ['one']) }
  let(:log)    { stub("Adium Log", :read => "asdf") }

  it "clears all parsers" do
    ChatStew.register(parser)
    ChatStew.clear_parsers!
    ChatStew.parse(log)
    parser.should have_received(:parse).never
  end
end
