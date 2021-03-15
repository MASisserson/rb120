# Pet Shelter

class Shelter
  def initialize
    @owners = []
    @unadopted_pets = []
  end

  def take_in(*pets)
    pets.each do |pet|
      self.unadopted_pets << pet
    end
  end

  def adopt(owner, pet)
    owner.adopt(self.unadopted_pets.delete(pet))
    self.owners << owner if !(self.owners.include? owner)
  end

  def print_adoptions
    self.owners.each do |owner|
      puts "#{owner.name} has adopted the following pets:"
      owner.pets.each do |pet|
        puts "a #{pet.species} named #{pet.name}"
      end
      puts ''
    end
  end

  def print_unadopted
    puts "The Animal Shelter has the following unadopted pets:"
    self.unadopted_pets.each do |pet|
      puts "A #{pet.species} named #{pet.name}"
    end
    puts
  end

  private

  attr_accessor :owners, :unadopted_pets
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    self.pets.size
  end

  def adopt(pet)
    self.pets << pet
  end

  private

  attr_writer :pets
end

class Pet
  attr_reader :species, :name

  def initialize(species, name)
    @species = species
    @name = name
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
asta         = Pet.new('dog', 'Asta')


phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.take_in(butterscotch, pudding, darwin, kennedy, sweetie, molly, chester, asta)
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts

shelter.print_unadopted
