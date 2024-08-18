# frozen_string_literal: true

require 'socket'
require_relative './packet/connect_packet'

require 'debug'

# Connection samidare
module Samidare
  # Connection module
  class Connection
    def initialize(socket)
      @socket = socket
    end

    def start
      connect_packet = Packet::ConnectPacket.new(@socket.recv(1024))
      binding.debugger
    end
  end
end
