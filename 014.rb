  require 'database_cleaner'
  
  module Chat
    class TestCase < ActiveSupport::TestCase
      include EM::Test
      default_timeout(10)
  
      # add some syntactic sugar
      class << self
        alias :scenario :test
      end
    end
  
    module Server
      class TestCase < ::Chat::TestCase
        # EM::Test defines alias for run method and
        # executes run_without_em inside event loop
        def run_without_em(result, &block)
          app = Chat::Server::Application.new
          app.start("localhost", 1234) # EM.start_server
          super                        
          app.stop                     # EM.stop_server
          DatabaseCleaner.clean        # truncate DB data after test
          done                         # EM.stop_event_loop
        end
      end
    end
  end
