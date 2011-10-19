require 'spec_helper'

describe ChatStew::Parsers::Adium, "#can_parse?" do
  let(:adium_log)  { File.new(File.join('spec', 'support', 'logs', 'adium_log.xml')) }
  let(:random_log) { File.new(File.join('spec', 'support', 'logs', 'random_log.html')) }

  it "returns true for an Adium log" do
    subject.can_parse?(adium_log).should be_true
  end

  it "returns false for a non-Adium log" do
    subject.can_parse?(random_log).should be_false
  end
end

describe ChatStew::Parsers::Adium, "#parse" do
  let(:adium_log) { File.new(File.join('spec', 'support', 'logs', 'adium_log.xml')) }
  let(:parsed) { subject.parse(adium_log) }

  it "correctly parses the sender" do
    parsed[0].sender.should == "this_is_me"
    parsed[1].sender.should == "this_is_them"
  end

  it "correctly parses the receiver" do
    parsed[0].receiver.should == "this_is_them"
    parsed[1].receiver.should == "this_is_me"
  end

  it "correctly parses the alias" do
    parsed[0].alias.should == "my_alias"
    parsed[1].alias.should == "their_alias"
  end

  it "correctly parses the message" do
    parsed[0].message.should == "first message > second message"
    parsed[1].message.should == "untrue! & I can prove it"
  end

  it "correctly parses the time" do
    parsed[0].time.should == DateTime.parse("2009-01-10T10:14:28-05:00")
    parsed[1].time.should == DateTime.parse("2009-01-10T20:15:30-05:00")
  end
end
