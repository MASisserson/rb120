# Create the Class

module Walkable
  def walk
    puts "Let's go for a walk"
  end
end

class Cat
  include Walkable

  attr_accessor :name

  def initialize(name)
    self.name = name
  end

  def greet
    puts "Hi, my name is #{self.name}!"
  end
end

kitty = Cat.new 'Charles'
kitty.greet
kitty.name = 'Luna'
kitty.greet
kitty.walk
