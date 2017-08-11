class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  def to_s
    name
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end
end

#puts "=== 1 ==="
#bob = Person.new('bob')
#p bob.name
#p bob.name = 'Robert'
#p bob.name
#

#puts "=== 2_3 ==="
#bob = Person.new('Robert')
#p bob.name
#p bob.first_name
#p bob.last_name
#bob.last_name = 'Smith'
#puts "=== p bob.name==="
#p bob.name
#puts
#bob.name = "John Adams"
#p bob.first_name
#p bob.last_name


#puts "=== 4 ==="
#bob = Person.new('Robert Smith')
#rob = Person.new('Robert Smith')
#p rob == bob

puts "=== 5  ==="
bob = Person.new('Robert Smith')
puts "The person's name is: #{bob}"

