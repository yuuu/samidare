# frozen_string_literal: true

require_relative 'samidare/version'
require_relative 'samidare/connection'

# Samidare module
module Samidare
  class Error < StandardError; end
  class InvalidPacket < StandardError; end

  class Samidare
    def initialize(host: '0.0.0.0', port: 1883)
      @server = nil
      @host = host
      @port = port
    end

    def start
      @server = server
      loop do
        socket, = @server.accept
        Connection.new(socket).start
      end
    rescue StandardError => e
      puts e.message
      puts e.backtrace
    ensure
      @server&.close
    end

    private

    def server
      serv = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
      sockaddr = Socket.sockaddr_in(@port, @host)
      serv.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, true)
      serv.bind(sockaddr)
      serv.listen(5)
      serv
    end
  end
end
