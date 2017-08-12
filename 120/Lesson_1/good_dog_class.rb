module Walkable
  def walk
    "I'm walking"
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

#puts "--- Animal method lookup ---"
#puts Animal.ancestors

#fido = Animal.new
#puts fido.speak
#puts fido.walk

module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end

  def self.some_out_of_place_method(num)
    num ** 2
  end
end

buddy = Mammal::Dog.new
kitty = Mammal::Cat.new
buddy.speak('Arf!')
kitty.say_name('kitty')
puts value = Mammal.some_out_of_place_method(4)

class GoodDog < Animal
  include Swimmable
  include Climbable
#  attr_accessor :name
#
#  def initialize(n)
#    self.name = n
#  end
#
#  def speak
#    #"#{self.name} says arf!"
#    super + " from GoodDog class"
#  end
end

#puts "---GoodDog metod lookup---"
#puts GoodDog.ancestors

#
#class Cat < Animal
#end
#
#sparky = GoodDog.new("Sparky")
#paws = Cat.new
#
#puts sparky.speak
##puts paws.speak
