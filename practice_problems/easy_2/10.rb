# Nobility

module Walkable
  def walk
    puts "#{self} #{gait} forward"
  end
end

module Commoner
  def to_s
    name
  end
end

module Uncommoner
  def to_s
    "#{title} #{name}"
  end
end

class Person
  include Walkable, Commoner
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable, Commoner
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable, Commoner
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

class Noble
  include Walkable, Uncommoner
  attr_reader :name, :title

  def initialize(name, title)
    @name = name
    @title = title
  end

  private

  def gait
    "struts"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

# kitty = Cat.new("Kitty")
# kitty.walk
# => "Kitty saunters forward"

# flash = Cheetah.new("Flash")
# flash.walk
# => "Flash runs forward"

byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"

# p byron.name == "Byron"
# p byron.title == "Lord"
