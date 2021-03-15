# What's the Output

require 'pry'

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name # Will output `Fluffy` ; If attr_reader is specified, calling puts on the name does not automatically call to_s on the instance variable.
# puts fluffy       # Will output "My name is FLUFFY" ; Calling puts on the class calls to_s automatically
# puts fluffy.name  # Will output `FLUFFY`
# puts name         # Will output `FLUFFY`

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

=begin

name is reassigned to `43` on `line 27`. `puts` only calls the instance method `to_s` when
an object of the `Pet` class is passed to it as an argument. If any instance method in the object
is invoked from, with, or in the object, the default Ruby `to_s` is used.

=end
