  class StatusFeature < Chat::Server::TestCase
    ONLINE, OFFLINE = 1, 0
  
    scenario "setting offline on connection close" do
      alice = TestMobile.new(self, :phone => "123")
      bob   = TestMobile.new(self, :phone => "456")
      
      [alice, bob].each do |mobile|
        mobile.register_and_login
        mobile.connect!
      end
  
      alice.add_to_friends(bob)
      alice.set_status(ONLINE, "on drugs")
      bob.receive_message!(:status) do |message|
        assert_equal message.body[:description], "on drugs"
        assert_equal message.body[:kind], ONLINE
      end
  
      alice.disconnect!
      bob.receive_message!(:status) do |message|
        assert_equal message.body[:description], "on drugs"
        assert_equal message.body[:kind], OFFLINE
      end
  
      [alice, bob].each(&:disconnect!)
    end
  end
