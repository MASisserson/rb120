# On the subject of the method lookup path

module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "i'm swimming."
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
    puts "I'm an animal, and I speak!"
  end
end

class GoodDog < Animal
  include Swimmable
  include Climbable
end

# puts "---Animeal method lookup---"
# puts Animal.ancestors

# fido = Animal.new
# fido.speak

puts "---GoodDog method lookup---"
puts GoodDog.ancestors
