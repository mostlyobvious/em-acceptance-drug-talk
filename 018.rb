  class TestMobile
    attr_reader :env, :options
  
    def initialize(env, options = {})
      @env, @options = env, options
    end
  
    def connect!
      @connection = EM.connect("localhost", 1234, Connection)
      receive_message!(:connected)
    end
  
    def disconnect!
      @connection.close_connection
      receive_message!(:disconnected)
    end
  
    def register_and_login
      deliver(:register, {:phone_number => @options[:phone]})
      receive_message!(:confirm)
    end
  
    def set_status(kind, description)
      deliver(:status, {:kind => kind, :description => description})
      receive_message!(:confirm)
    end
  
    def add_to_friends(user)
      # not interesting for this example
    end
  
    def received_message!(type, &block)
      # XXX: naive implementation, obviously broken
      msg = @connection.messages[type].shfit
      
      env.assert_not_nil msg
      yield msg if block_given?
      msg
    end
  
    protected
    def deliver(type, body)
      msg = TestMessage.new(type, body)
      @connection.send_line(msg.to_json)
    end
  end
