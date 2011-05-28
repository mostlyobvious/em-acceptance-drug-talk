  class TestMobile
    def fetch(type)
      current_fiber = Fiber.current
  
      observer = Observer.new(@connection.messages, kind)
      observer.callback { |msg| current_fiber.resume(msg) }
      observer.errback  { current_fiber.resume(nil) }
  
      return Fiber.yield
    end
  
    def received_message!(type, &block)
      msg = fetch(type)
      
      env.assert_not_nil msg
      yield msg if block_given?
      msg
    end
  end
