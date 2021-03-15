class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

p bob = Person.new("Steve")
p bob.name = "Bob"
