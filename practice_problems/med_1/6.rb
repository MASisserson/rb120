# Number Guesser Part 1

require 'pry'

class GuessingGame
  attr_accessor :number, :count, :won

  def initialize(low, high)
    @low = low
    @high = high
  end
  
  def play
    system 'clear'
    @number = (@low..@high).to_a.sample
    @count = Math.log2(@high - @low).to_i + 1
    @won = nil
    loop do
      remaining_guesses
      guess = read_guess
      judge_guess(guess)
      count_down
      break if game_over?
    end

    display_result
  end

  private

  def remaining_guesses
    puts "You have #{count} guesses remaining."
  end

  def read_guess
    answer = nil
    print "Enter a number between #{@low} and #{@high}: "
    loop do
      answer = gets.chomp
      break if (answer.to_i.to_s == answer) && (@low..@high).to_a.include?(answer.to_i)
      print "Invalid guess. Enter a number between 1 and 100: "
    end

    answer.to_i
  end

  def judge_guess(guess)
    if guess == number
      self.won = true
    elsif guess < number
      puts "Your guess is too low."
    else
      puts "Your guess is too high."
    end
    puts
  end

  def count_down
    self.count -= 1
  end

  def game_over?
    count.zero? || won
  end

  def display_result
    if won
      puts "You won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end
end

game = GuessingGame.new(1, 100)
game.play
