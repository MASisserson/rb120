class MyCar
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

  def shut_off
    speed = 0
    engine_on = false
    puts "The car is off"
  end

  def spray_paint(new_color)
    self.color = new_color
  end

  def to_s
    "My car is a #{self.color}, #{self.year}, #{self.model}!"
  end
end


malibu = MyCar.new(2004, 'grey', 'chevrolet malibu')
# p malibu.color
# p malibu.year
# p malibu.model
# p malibu.speed
# p malibu.engine_on

# p malibu.turn_on
# p malibu.engine_on
# malibu.speed_up(20)
# malibu.brake(10)
# malibu.brake(30)
# malibu.shut_off

# p malibu.color
# p malibu.spray_paint 'blue'
# p malibu.color

# MyCar.gas_mileage 100, 10

puts malibu
puts malibu.year
