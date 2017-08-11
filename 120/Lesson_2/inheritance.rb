class Pet
  def run
    'running!'
  end
  
  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

class Bulldog < Dog
  def swim
    "cant't swim!"
  end
end

#puts "=== 1 ==="
#teddy = Dog.new
#puts teddy.speak
#puts teddy.swim
#
#karl = Bulldog.new
#puts karl.speak
#puts karl.swim
#
#
puts "=== 2 ==="
pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

p pete.run
#p pete.speak
puts

p kitty.run
p kitty.speak
#p kitty.fetch
puts

p dave.speak
puts

p bud.run
p bud.swim
puts

p Bulldog.ancestors
