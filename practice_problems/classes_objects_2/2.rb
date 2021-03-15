# Hello, Chloe!

class Cat
  attr_accessor :name

  def initialize(name)
    self.name = name
  end

  def rename(name)
    self.name = name
  end
end

kitty = Cat.new('Sophie')
p kitty.name
kitty.rename('Chloe')
p kitty.name
