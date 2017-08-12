def prefix(str)
  str << Time.now.to_s
  "Mr. " + str
end

name = 'joe'
name = prefix(name)

puts name
