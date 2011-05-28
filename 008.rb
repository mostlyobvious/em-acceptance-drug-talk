
  require 'fiber'
  
  f = Fiber.new do
    puts "say: "
    Fiber.yield
    puts "World!"
  end
  
  f.resume     # say:
  puts "Hello" # Hello
  f.resume     # World!
  
  f.resume     # fibered_hello_world.rb:11:in `resume':
               # dead fiber called (FiberError)



