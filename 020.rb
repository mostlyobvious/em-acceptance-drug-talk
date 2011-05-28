  class Observer
    include EM::Deferrable
  
    def initialize(collection, type)
      timeout(1) # we can set observe timeout
                 # if time has passed, fail() is executed
                 # and errback chain is called
  
      @messages    = collection
      @shift_timer = EM.add_periodic_timer(0.1) { shift_message(type) }
  
      self.callback { EM.cancel_timer(@shift_timer) }
      self.errback  { EM.cancel_timer(@shift_timer) }
    end
  
    def shift_message(type)
      if msg = @messages[type].shift
        succeed(msg)
      end
    end
  end
