module Towable
  def tow
    "I can tow another vehicle!"
  end
end

class Vehicle
  @@number_of_vehicles = 0

  attr_reader :year, :model
  attr_accessor :speed, :engine_on, :color

  def self.gas_mileage(miles, gallons)
    puts "The car gets #{miles / gallons} miles per gallon."
  end
    
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
    @engine_on = false
    @@number_of_vehicles += 1
  end

  def speed=(argument)
    @speed = argument
    puts "speed= was invoked"
  end

  def speed_up(difference)
    self.speed += difference
    puts "You have accelerated to #{self.speed} mph."
  end

  def brake(difference)
    if speed - difference < 0
      self.speed = 0
      puts "You have deccelerated to #{self.speed} mph."
    else
      self.speed -= difference
      puts "You have deccelerated to #{self.speed} mph."
    end
  end

  def turn_on
    speed = 0
    engine_on = true
    puts "The engine revs up"
  end

  def turn_off
    speed = 0
    engine_on = false
    puts "The car is off"
  end

  def spray_paint(new_color)
    self.color = new_color
  end

  def self.vehicle_count
    puts "#{@@number_of_vehicles} vehicles have been made."
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def age
    "Your #{self.model} is #{years_old} years old."
  end

  private

  def years_old
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s
    "My car is a #{self.color}, #{self.year}, #{self.model}!"
  end
end

class MyTruck < Vehicle
  include Towable

  NUMBER_OF_DOORS = 2

  def to_s
    "My truck is a #{self.color}, #{self.year}, #{self.model}!"
  end
end

malibu = MyCar.new(2004, 'gray', 'Chevrolet Malibu Maxx')
ford = MyTruck.new(1984, 'black', 'Ford Ranger')
p ford.tow

puts malibu
puts ford
puts malibu.age

Vehicle.vehicle_count

class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end
end

joe = Student.new("Joe", 90)
bob = Student.new("Bob", 84)
puts "Well done!" if joe.better_grade_than?(bob)
