=begin

A module is a template that can define functions.
Access to a module can be granted to classes so that
those classes can take functionality from that module.
Objects cannot be made directly from modules, however.


=end

module PathFinder
  def determine_meaning
    puts 42
  end
end

class MyClass
  include PathFinder
end

class_object = MyClass.new
class_object.determine_meaning
