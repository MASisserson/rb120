# Fix the Program - Flight Data

class Flight
  # attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

=begin

att_accessor :database_handle should be removed to future proof the program.
There shouldn't be a need to read and write @database_handle directly. By eliminating that code, it prevents
future coders from calling it. If they did call it, and then the implementation of this code was changed
such that Database was no longer used, that code they wrote would be ruined.

=end
