require 'socket'
require 'cgi'
class String
  def unescape
    CGI.unescape(self)
  end
end
"".unescape
def github
  return Object.new.instance_eval do
    def debug(client)
      puts @raw_in
      puts @headers
      puts @body
    end
    def server
      @server ||= TCPServer.open(9898)
    end
    def from(client)
      @raw_in  = client.readlines
      @headers = @raw_in[0..4]
      @body    = @raw_in.last.unescape
    end
    def to(client)
        client.puts(Time.now.ctime)  # Send the time to the client
        client.puts "Closing the connection. Bye!"
    end
    def accept
        client = server.accept       # Wait for a client to connect
        begin
          from(client)
          debug(client)
          to(client)
        rescue Exception => e
          puts e
        ensure
        client.close                 # Disconnect from the client
        end
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
