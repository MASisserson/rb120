# Calculated Age

class Person
  def age=(a)
    @age = double(a)
  end

  def age
    double(@age)
  end

  private

  def double(value)
    value * 2
  end
end

person1 = Person.new
person1.age = 20
puts person1.age
