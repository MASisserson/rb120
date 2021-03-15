# module Speak
#   def speak(sound)
#     puts sound
#   end
# end

# class Human
#   include Speak
# end

class GoodDog
  DOG_YEARS = 7
  attr_accessor :name, :height, :weight, :age
  @@number_of_dogs = 0
  
  def initialize(n, h, w, a)
    @name = n
    @height = h
    @weight = w
    @age = a * DOG_YEARS

    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end
    
  def self.what_am_i
    "I'm a GoodDog class!"
  end
    
  def speak
    "#{name} says arf!"
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end

end

puts GoodDog.total_number_of_dogs

sparky = GoodDog.new 'Sparky', '12 inches', '10 lbs', 2
# puts sparky.info
puts sparky.age
# sparky.change_info 'Spartacus', '24 inches', '45 lbs'
# puts sparky.info

puts GoodDog.total_number_of_dogs
puts sparky
p sparky
puts sparky.info
