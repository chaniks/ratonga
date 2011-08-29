module Ratonga
  module Login
    module Server
      def login(userid, password)
        puts "login: #{DRb.current_server}"
        if @clients[userid].nil?
          false
        else
          client = DRbObject.new_with_uri @clients[userid][:uri]
          client.login(password)
        end
      end
    end

    module Client
      attr_writer :password

      def login(password)
        @password == password
      end
    end
  end

  class Server
    include Login::Server
  end

  class Client
    include Login::Client
  end
end
