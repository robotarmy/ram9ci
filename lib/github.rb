require 'socket'
def github
  return Object.new.instance_eval do
    def server
      @server ||= TCPServer.open(9898)
    end
    def listen
      puts "waiting.."
      loop {                         # Servers run forever
        client = server.accept       # Wait for a client to connect
        client.puts(Time.now.ctime)  # Send the time to the client
        client.puts "Closing the connection. Bye!"
        client.close                 # Disconnect from the client
      }
      self
    end
    self
  end
end
