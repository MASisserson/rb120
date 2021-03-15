# Reverse Engineering

class Transform
  def initialize(mumbo)
    @jumbo = mumbo
  end

  def uppercase
    @jumbo.upcase
  end

  def self.lowercase(string)
    string.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')
