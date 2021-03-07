module Speak
  def speak(sound)
    puts sound
  end
end

class GoodDog
  attr_accessor :name, :height, :weight
  
  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
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
end

class HumanBeing
  include Speak
end

sparky = GoodDog.new 'Sparky', '12 inches', '10 lbs'
puts sparky.info

sparky.change_info 'Spartacus', '24 inches', '45 lbs'
puts sparky.info
