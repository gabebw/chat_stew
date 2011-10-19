require 'nokogiri'
require 'date'
require 'time'

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
        chat_messages = doc.search('chat message')
        account       = doc.at('chat')[:account]
        other_account = chat_messages.detect{|m| m[:sender] != account }[:sender]

        chat_messages.map do |message|
          AdiumMessage.new(message[:sender],
                           message[:sender] == account ? other_account : account,
                           message[:alias],
                           message.text,
                           DateTime.parse(message[:time]))
        end
      end
    end
  end
end
