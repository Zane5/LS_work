module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  attr_accessor :color
  attr_accessor :model, :year
  @@number_of_vehicles = 0

  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles"
  end

  def initialize(year, nodel, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
    @@number_of_vehicles += 1
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_down
    puts "Let's park this bad boy!"
  end
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def spray_paint(color)
    self.color = color
    puts "You new #{color} paint job looks great!"
  end

  def age
    "Your #{self.model} is #{years_old} years old."
  end

  protected

  def protected_method
    puts "protected method"
  end

  private

  def years_old
    Time.now.year - self.year
  end

  def private_method
    puts "private method"
  end
end

class Van < Vehicle
  def call_me
    protected_method
    private_method
  end
end

v = Van.new(1997, 'chevy lumina', 'white')
v.call_me


#class MyCar < Vehicle
#  NUMBER_OF_DOORS = 4 
#
#  def to_s
#    "My car is a #{self.color}, #{self.year}, #{self.model}!"
#  end
#end
#
#class MyTruck < Vehicle
#  include Towable
#
#  NUMBER_OF_DOORS = 2
#
#  def to_s
#    "My truck is a #{self.color}, #{self.year}, #{self.model}!"
#  end
#end
#
#lumina = MyCar.new(1997, 'chevy lumina', 'white')
#lumina.speed_up(20)
#lumina.current_speed
#puts
#lumina.speed_up(20)
#lumina.current_speed
#puts
#lumina.brake(20)
#lumina.current_speed
#puts
#
#lumina.brake(20)
#lumina.current_speed
#puts
#
#lumina.shut_down
#MyCar.gas_mileage(13, 351)
#lumina.spray_paint("red")
#puts lumina
#
#puts "=== lumina age ==="
#puts lumina.age
#
#puts "=== MyCar ==="
#puts MyCar.ancestors
#puts
#puts "=== MyTruck ==="
#puts MyTruck.ancestors
#puts
#puts "=== Vehicle ==="
#puts Vehicle.ancestors
