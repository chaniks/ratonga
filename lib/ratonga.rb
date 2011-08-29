require "ratonga/version"
require 'uri'
require 'socket'
require 'drb'
require 'drb/patch'

module Ratonga
  module DRbService
    def uri
      @service.uri
    end

    def port
      URI.parse(uri).port
    end

    private
    def start(port = nil)
      if port.nil?
        uri = nil
      else
        uri = "druby://#{Socket.gethostname}:#{port}"
        if existing = DRb.fetch_server(uri)
          puts "stops #{existing}"
          existing.stop_service
        end
        raise if DRb.fetch_server(uri)
      end
      @service = DRb.start_service uri, self
    end
  end

  class Server
    include DRbService

    def initialize(port = 3931)
      @clients = {}
      start(port)
    end

    def register(userid, uri)
      puts "register: #{DRb.current_server}"
      @clients[userid] = {uri: uri}
    end
  end

  class Client
    include DRbService

    attr_reader :server, :userid

    def initialize(userid = nil, port = nil)
      @userid = userid
      start(port)
      connect
    end

    def connect(server_uri = 'druby://localhost:3931')
      @server = DRbObject.new_with_uri server_uri
      @server.register(userid, uri)
    end
  end
end
