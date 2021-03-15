class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
  end

  # assume the method definition below is above the "private" keyword

  def public_disclosure
    "#{self.name} in human years is #{human_years}"
  end

  private # Anything below this is inaccessible from the outside.

  def human_years
    age * DOG_YEARS
  end
end

p sparky = GoodDog.new("Sparky", 4)
p sparky.public_disclosure
p sparky.human_years
