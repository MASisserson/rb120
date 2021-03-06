# Refactoring Vehicles

class Vehicle
  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end

  private

  attr_reader :make, :model
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end

  private

  attr_reader :payload
end
