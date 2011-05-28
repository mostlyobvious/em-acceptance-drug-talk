  EM.connect("localhost", 1234, Connection)
  
  class Connection < EM::Connection
    include EM::Protocols::LineProtocol
  
    attr_accessor :messages
  
    def initialize(*args)
      @messages = Hash.new { |h, k| h[k] = [] }
      # @messages[:status] = [first, second, ...]
    end
  
    def connection_completed
      @messages[:connected] << true
    end
  
    def unbind
      @messages[:disconnected] << true
    end
  
    def receive_line(data)
      msg = TestMessage.parse(data)
      @messages[msg.type] << msg
    end
  
    def send_line(data)
      send_data("#{data.strip}\n")
    end
  end
