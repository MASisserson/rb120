module Designable
  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def prompt(text)
    puts colorize("=> #{text}", 32)
  end

  def prompt_ylw(text)
    puts colorize("=> #{text}", 33)
  end

  def clear_screen_prompt(text)
    clear_screen
    puts colorize("=> #{text}", 32)
    new_line
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

  def add_conjunction(array, punctuation, conjunction)
    number_string = String.new
    array.each do |element|
      if element == array.last
        number_string << "#{conjunction} #{element}"
        next
      end
      number_string << "#{element}#{punctuation}"
    end
    number_string
  end
end

module Validatable
  def yes_or_no
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if %w(y yes n no).include? answer
      puts %(Sorry, must be "y" or "n")
    end
    %w(y yes).include? answer
  end

  def read_integer_response
    answer = nil
    loop do
      answer = gets.chomp.strip
      break if answer == answer.to_i.to_s
      prompt "Please input an integer without extraneous zeroes."
    end
    answer.to_i
  end

  def read_integer_response_between(low, high)
    answer = nil
    loop do
      answer = read_integer_response
      break if (low..high).include? answer
      prompt "Please input an integer between #{low} and #{high}, inclusive."
    end
    answer
  end

  def read_string_response
    gets.chomp.strip
  end

  def read_string_response_of_size(size)
    size = 0 if size < 0
    loop do
      answer = gets.chomp.strip
      return answer if answer.length == size
      if (0..1).include? size
        prompt "Please keep your response to #{size} character."
      else
        prompt "Please keep your response to #{size} characters."
      end
    end
  end

  def read_string_response_greater_than(size)
    size = 0 if size < 0
    loop do
      answer = gets.chomp.strip
      return answer if answer.length > size
      if size == 0
        prompt "Please respond with at least #{size + 1} character."
      else
        prompt "Please respond with at least #{size + 1} characters."
      end
    end
  end

  def continue_with_enter
    loop do
      print "Press ENTER to continue"
      input = gets
      break if input == "\n"
      puts "Please only press ENTER"
    end
  end
end

class Board
  CENTER_SPACE = 5
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]] # diagonal
  BOARD_SIZE = 3

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def [](*num_arr)
    return @squares[num_arr].marker if num_arr.size == 1
    num_arry.map { |num| @squares[num].marker }
  end

  def free_corners
    unmarked_keys.select { |square_id| [1, 3, 7, 9].include? square_id }
  end

  def center_marked?
    @squares[CENTER_SPACE].marked?
  end

  def win_condition(marker)
    WINNING_LINES.each do |line|
      winning_move = check_line_almost_full(line, marker)
      next if winning_move.nil?
      return winning_move
    end
    nil
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def game_over?
    full? || someone_won?
  end

  def winning_marker
    WINNING_LINES.each do |line|
      full_line_mark = full_line_check(@squares.values_at(*line))
      next if full_line_mark.nil?
      return full_line_mark
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  private

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def full_line_check(squares)
    return if squares.collect(&:marker).include? Square::INITIAL_MARKER
    squares.collect(&:marker).first if squares.collect(&:marker).uniq.size == 1
  end

  def check_line_almost_full(line, marker)
    array = @squares.values_at(*line).collect(&:marker)
    return unless array.count(marker) == (BOARD_SIZE - 1) &&
                  array.count(Square::INITIAL_MARKER) == 1
    line.each do |num|
      return num if @squares[num].marker == Square::INITIAL_MARKER
    end
    nil
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

  def marked?
    marker != INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :name, :marker, :score

  def initialize(name, marker)
    @name = name
    @marker = marker
    @score = 0
  end

  def wins_round
    @score += 1
  end

  def reset
    @score = 0
  end
end

class TTTGame
  include Designable, Validatable

  COMPUTER_MARKER = "O"

  def initialize
    @board = Board.new
    @human = Player.new(request_name, request_marker_choice)
    @computer = Player.new("Joe", COMPUTER_MARKER)
    @current_player = human
    @winning_score = play_to_what
  end

  def play
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer, :winning_score
  attr_accessor :current_player

  def main_game
    loop do
      play_round
      display_winner
      break unless play_again?
      reset_all
    end
  end

  def play_round
    loop do
      display_scores
      display_board
      player_move
      display_result
      increment_score
      break if someone_won?
      reset_board
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.game_over?
      if human_turn?
        clear_screen
        display_scores
        display_board
      end
    end
  end

  def play_to_what
    prompt "How many wins do you wish to play to? (max 5)"
    read_integer_response_between 1, 5
  end

  def request_marker_choice
    prompt "Please decide on a single character to use as a marker:"
    loop do
      response = read_string_response_of_size 1
      return response if response.upcase != "O"
      prompt "Sorry, Joe got here first and called dibs on that marker."
    end
  end

  def request_name
    clear_screen
    prompt "What should I call you?"
    read_string_response_greater_than 0
  end

  def display_welcome_message
    clear_screen_prompt "Welcome to Tic Tac Toe first to #{winning_score}!"
  end

  def display_goodbye_message
    clear_screen_prompt "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    prompt "You're #{human.marker}, #{computer.name} is #{computer.marker}."
    new_line
    board.draw
    new_line
  end

  def clear_screen_and_display_board
    clear_screen
    display_board
  end

  def human_turn?
    current_player == human
  end

  def current_player_moves
    if human_turn?
      human_moves
      self.current_player = computer
    else
      computer_moves
      self.current_player = human
    end
  end

  def human_moves
    prompt "Choose a square: #{joinor(board.unmarked_keys)}"
    square = nil
    loop do
      square = read_integer_response
      break if board.unmarked_keys.include?(square)
      prompt "Please choose an available square: #{joinor(board.unmarked_keys)}"
    end

    board[square] = human.marker
  end

  def computer_about_to_win?
    board.win_condition(computer.marker)
  end

  def human_about_to_win?
    board.win_condition(human.marker)
  end

  def center_unfilled?
    !board.center_marked?
  end

  def corners_available?
    board.unmarked_keys.size > 5
  end

  def computer_moves
    return attempt_win  if computer_about_to_win?
    return prevent_loss if human_about_to_win?
    return fill_center  if center_unfilled?
    return fill_corner  if corners_available?
    random_pick
  end

  def computer_assessment
    return 1 if board
  end

  def attempt_win
    board[board.win_condition(computer.marker)] = computer.marker
  end

  def prevent_loss
    board[board.win_condition(human.marker)] = computer.marker
  end

  def fill_center
    board[Board::CENTER_SPACE] = computer.marker
  end

  def fill_corner
    board[board.free_corners.sample] = computer.marker
  end

  def random_pick
    board[board.unmarked_keys.sample] = computer.marker
  end

  def increment_score
    case board.winning_marker
    when human.marker    then human.wins_round
    when computer.marker then computer.wins_round
    end
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker    then prompt "You won!"
    when computer.marker then prompt "#{computer.name} won!"
    else                      prompt "It's a tie!"
    end

    continue_with_enter
  end

  def display_scores
    prompt_ylw "The score so far:"
    if human.name.strip == "Joe"
      prompt_ylw "You: #{human.score}"
    else
      prompt_ylw "#{human.name}: #{human.score}"
    end
    prompt_ylw "#{computer.name}: #{computer.score}"
    new_line
  end

  def display_winner
    [human, computer].each do |player|
      if player.score == winning_score
        prompt "#{player.name} wins with #{winning_score} points!"
      end
    end
  end

  def play_again?
    prompt "Would you like to play again? (y/n)"
    yes_or_no
  end

  def reset_board
    board.reset
    clear_screen
  end

  def reset_all
    board.reset
    human.reset
    computer.reset
    clear_screen
  end

  def someone_won?
    [human.score, computer.score].include? winning_score
  end
end

game = TTTGame.new
game.play
