class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end

  def self.what_am_i
    puts "I'm a GoodDog class!"
  end

  def to_s
    "this is dog"
  end
end

sparky = GoodDog.new("Sparky")
#puts sparky.speak
#puts sparky.name
#sparky.name = "Spartacus"
#puts sparky.name
puts sparky

#GoodDog.what_am_i
