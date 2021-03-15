# On the subject of inheritance

class Animal
  attr_accessor :name

  def initialize
  end

  # def initialize(name)
  #   @name = name
  # end
  
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  attr_accessor :color

  def initialize(name, color)
    super()
    @color = color
  end

  def speak
    "#{self.name} says arf!"
  end
end

class Cat < Animal
  def speak
    super + " from Cat class"
  end
end

p bruno = GoodDog.new('Bruno', 'brown')
p bruno.name
p bruno.color
