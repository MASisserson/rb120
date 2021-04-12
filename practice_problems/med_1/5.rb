# Stack Machine Interpretation

module CustomErrors
  class MinilangError < StandardError; end

  class BadTokenError < MinilangError; end

  class EmptyStackError < MinilangError; end
end

class Minilang
  include CustomErrors

  VALID_COMMANDS = %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  attr_accessor :commands, :stack, :register

  def initialize(commands)
    @commands = commands.split
  end

  def eval
    @stack = []
    @register = 0
    commands.each { |command| parse(command) }
  rescue MinilangError => error
    puts error.message
  end

  private

  def parse(command)
    if VALID_COMMANDS.include? command
      send command.downcase.intern
    elsif command.to_i.to_s == command
      n(command)
    else
      raise BadTokenError, "Invalid token: #{command}"
    end
  end

  def n(number)
    @register = number.to_i
  end

  def push
    stack << register
  end

  def add
    self.register += pop
  end

  def sub
    self.register -= pop
  end

  def mult
    self.register *= pop
  end

  def div
    self.register /= pop
  end

  def mod
    self.register = register % pop
  end

  def pop
    raise EmptyStackError, "Empty stack!" if stack.empty?
    self.register = stack.pop
  end

  def print
    puts register
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
