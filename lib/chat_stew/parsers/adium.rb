require 'nokogiri'
require 'date'
require 'time'

Struct.new("Message", :sender, :alias, :message, :time)

module ChatStew
  module Parsers
    class Adium
      def can_parse?(file)
        contents = file.read
        file.rewind
        return contents.include?('<?xml version="1.0" encoding="UTF-8" ?>') &&
          contents.include?('<chat xmlns="http://purl.org/net/ulf/ns/0.4-02"')
      end

      def parse(file)
        doc = Nokogiri.XML(file)
        doc.search('chat message').map do |message|
          Struct::Message.new(message[:sender], message[:alias], message.text, DateTime.parse(message[:time]))
        end
      end
    end
  end
end
