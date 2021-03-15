# Lecture code
class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name # The person's name
    @pets = []  # Sets up an array to store pet objects belonging to the person
  end
end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud

bob.pets                      # => [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]
