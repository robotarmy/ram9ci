require 'socket'
def github
  return Object.new.instance_eval do
    attr_accessor :raw_in, :headers, :body
    def debug(client)
      puts self.raw_in
      puts self.headers
      puts self.body
    end
    def server
      @server ||= TCPServer.open(9898)
    end
    def in(client)
      self.raw_in = client.readlines
      self.headers = raw_in[0..4]
      self.body = raw_in.last
    end
    def out(client)
        client.puts(Time.now.ctime)  # Send the time to the client
        client.puts "Closing the connection. Bye!"
    end
    def accept
        client = server.accept       # Wait for a client to connect
        in(client)
        debug(client)
        out(client)
        client.close                 # Disconnect from the client
    end
    def listen
      puts "waiting.."
      loop {                         # Servers run forever
        accept
      }
      self
    end
    self
  end
end
