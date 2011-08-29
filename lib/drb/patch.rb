require 'drb'

module DRb
  class DRbServer
    alias :stop_service_orig :stop_service

    def stop_service
      stop_service_orig
      @grp.list.each {|t| t.raise Interrupt if t.status.eql? 'sleep'}
    end

    def main_loop
      Thread.start(@protocol.accept) do |client|
        @grp.add Thread.current
        Thread.current['DRb'] = { 'client' => client ,
                                  'server' => self }
        DRb.mutex.synchronize do
          client_uri = client.uri
          @exported_uri << client_uri unless @exported_uri.include?(client_uri)
        end
        loop do
          begin
            succ = false
            invoke_method = InvokeMethod.new(self, client)
            succ, result = invoke_method.perform
            if !succ && verbose
              p result
              result.backtrace.each do |x|
                puts x
              end
            end
            client.send_reply(succ, result) rescue nil
          ensure
            client.close unless succ
            if Thread.current['DRb']['stop_service']
              Thread.new { stop_service }
              client.close if client.alive?
              break
            end
            break unless succ
          end
        end
      end
    rescue Errno::EBADF
      puts "Rescued from :#{$!}"
    end
  end
end

