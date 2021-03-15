# Method Lookup (Part 3)

module Flyable
  def fly
    "I'm flying!"
  end
end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
  include Flyable
end

bird1 = Bird.new('Red')
bird1.color

=begin

Method Lookup Path for `line 25`

```
Bird
Flyable
Animal
```

=end
