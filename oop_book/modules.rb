# On the subject of modules

module Swimmable
  attr_accessor :speed
  @speed = 20
  
  def swim
    "I'm swimming!"
  end
end

class Animal; end

class Fish < Animal
  include Swimmable
end

class Mammal < Animal
end

class Cat < Mammal

end

class Dog < Mammal
  include Swimmable
end

sparky = Dog.new
neemo  = Fish.new
paws   = Cat.new
whiskers = Cat.new
p whiskers == paws

# puts Dog.ancestors

p sparky.swim
p neemo.swim

p sparky.speed= 10
p sparky.speed
p neemo.speed
p Swimmable.speed
