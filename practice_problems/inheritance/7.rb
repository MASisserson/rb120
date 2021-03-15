# Method Lookup (Part 1)

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new('Black')
cat1.color

=begin

Method Lookup Path for cat1.color
Cat
Animal

=end
