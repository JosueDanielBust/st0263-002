#!/usr/bin/env ruby

require 'socket'

class Client
  class << self
    attr_accessor :host, :port
  end

  def self.request
    @client = TCPSocket.new(host, port)
    listen
    send
  end

  def self.listen
    Thread.new do
      loop do
        incoming = @client.gets
        if ( incoming.to_s.size > 1 )
          puts "> #{incoming}"
        else
          exit!
        end
      end
    end
  end

  def self.send
    Thread.new do
      loop do
        msg = $stdin.gets.chomp
        @client.puts(msg) if msg.size >= 1
      end
    end.join
  end
end


Client.host = ENV['CSIP']
Client.port = ENV['CPORT']
Client.request
