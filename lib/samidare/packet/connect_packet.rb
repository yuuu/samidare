# frozen_string_literal: true

require_relative './packet'
require_relative './fixed_header'

module Samidare
  module Packet
    class ConnectPacket < Packet
      attr_reader :msb, :lsb, :protocol_name, :version, :flags

      def initialize(message)
        fixed_header, message = FixedHeader.parse(message)

        super(fixed_header)
        @message = message

        parse_protocol_name
        parse_protocol_version
        parse_connect_flags
      end

      private

      def parse_protocol_name
        @msb, @lsb, @protocol_name = @message.unpack('CCA4')
        @message = @message.byteslice(6..)
        raise InvalidPacket if @msb != 0 || @lsb != 4 || @protocol_name != 'MQTT'
      end

      def parse_protocol_version
        @version = @message.unpack1('C')
        @message = @message.byteslice(1..)
        raise InvalidPacket unless [4, 5].include?(version)
      end

      def parse_connect_flags
        @flags = @message.unpack1('C')
        @message = @message.byteslice(1..)
        reserved, = (0...8).map { |i| (flags >> i) & 1 }
        raise InvalidPacket unless reserved.zero?
      end
    end
  end
end
