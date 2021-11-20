#!/usr/bin/env ruby

require 'socket'

class Server
  def initialize(port)
    @server = TCPServer.new(port)
    @connections = []
    puts "Listening on port #{port}"
  end

  def start
    Socket.accept_loop(@server) do |connection|
      @connections << connection
      ip = connection.remote_address.ip_address
      puts "[#{Time.now}] - #{ip} Connected"
      Thread.new do
        loop do
          handle(connection)
        end
      end
    end
  end

  private

  def handle(connection)
    request = connection.gets
    connection.close if request.nil?
    @connections.each do |client|
      next if client.closed?
      client.puts(request) if client != connection && !client.closed?
    end
    puts "[#{Time.now}] - Client disconnected" if connection.closed?
  end

end

server = Server.new( ENV['CPORT'] )
server.start
