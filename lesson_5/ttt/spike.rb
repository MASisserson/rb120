require 'pry'

module Designable
  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def prompt(text)
    puts colorize("=> #{text}", 32)
  end

  def say(text)
    new_line
    puts colorize(text.to_s, 33)
    new_line
  end

  def new_line
    puts
  end

  def clear_screen
    system 'clear'
  end

  def read_response
    gets.chomp.downcase.strip
  end

  def read_name
    gets.chomp.strip
  end

  def joinor(array, punctuation=', ', conjunction='or')
    return array.join if array.size <= 1
    return "#{array[0]} #{conjunction} #{array[1]}" if array.size == 2
  
    add_conjunction(array, punctuation, conjunction)
  end
end

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]] # diagonal

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!detect_winner
  end

  # returns winning marker or nil
  def detect_winner
    WINNING_LINES.each do |line|
      if count_marker(TTTGame::HUMAN_MARKER, (@squares.values_at(*line)) == 3
        return TTTGame::HUMAN_MARKER
      elsif count_marker(TTTGame::COMPUTER_MARKER, (@squares.values_at(*line)) == 3
        return TTTGame::COMPUTER_MARKER
      end
    end
    nil
  end

  def count_marker(marker, squares)
    squares.collect(&:marker).count(marker)
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  include Designable

  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def play
    display_welcome_message

    loop do
      display_board
      loop do
        human_moves
        break if board.someone_won? || board.full?
        # break if someone_won? || board_full?

        computer_moves
        break if board.someone_won? || board.full?

        display_board
      end
      display_result
      break unless play_again?
      puts "Let's play again!"
    end
    display_goodbye_message
  end

  private

  def display_welcome_message
    prompt "Welcome to Tic Tac Toe!"
    new_line
  end

  def display_goodbye_message
    prompt "thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    clear_screen
    prompt "You're a #{human.marker}, Computer is a #{computer.marker}."
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
    puts ""
  end

  def human_moves
    prompt "Choose a square between (#{board.unmarked_keys.join(', ')}):"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board.set_square_at(square, human.marker)
  end

  def computer_moves
    board.set_square_at(board.unmarked_keys.to_a.sample, computer.marker)
  end

  def display_result
    display_board

    case board.detect_winner
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end
end

game = TTTGame.new
game.play
