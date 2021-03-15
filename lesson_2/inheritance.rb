# Lecture: Inheritance

class Pet
  def run
    'running!'
  end

  def jump
    'jumping'
  end
end

class Cat < Pet
  def speak
    'Meow!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class BullDog < Dog
  def swim
    "Can't swim!"
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"
lion = Cat.new
puts lion.speak
puts BullDog.ancestors
