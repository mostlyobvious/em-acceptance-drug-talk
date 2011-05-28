  class TestMobile
    attr_reader :env, :options
  
    def initialize(env, options = {})
      @env, @options = env, options
    end
  
    def connect!
    end
  
    def register_and_login
    end
  
    def disconnect!
    end
  
    def set_status(kind, description)
    end
  
    def add_to_friends(user)
    end
  
    def received?(type, block)
    end
  end
