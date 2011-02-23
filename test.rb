class TestClass
  attr_accessor :testt
  @testt = 1
  def self.testt
    @testt
  end
  
  def self.testt=(val)
    @testt = val
  end

  def bar
    puts "hello"
  end
end


TestClass.new.bar
TestClass.testt = 3
puts TestClass.testt
