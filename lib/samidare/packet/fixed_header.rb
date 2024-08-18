# frozen_string_literal: true

module Samidare
  module Packet
    class FixedHeader
      attr_reader :type, :flags, :len

      TYPE_CONNECT = 1

      def self.parse(message)
        type, len = message.unpack('CC')
        message = message.byteslice(2..)

        flags = (type & 0b00001111)
        type = (type >> 4)

        [new(type:, flags:, len:), message]
      end

      def initialize(type:, flags:, len:)
        @type = type
        @flags = flags
        @len = len
      end
    end
  end
end
