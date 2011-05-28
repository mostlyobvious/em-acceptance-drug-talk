
                           Tools: EM::Spec
  
  class EmSpecTest < Test::Unit::TestCase
    include EventMachine::Test
  
    def test_timer
      start = Time.now
  
      EM.add_timer(0.5) {
        assert_in_delta 0.5, Time.now-start, 0.1
        done # it does EM.stop_event_loop
      }
    end
  end



