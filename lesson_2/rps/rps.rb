# Rock Paper Scissors Code

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
end

class Move
  attr_reader :value

  def initialize(value)
    @value = parse_value(value)
  end

  def >(other_move)
    WIN_LIST[value].include? other_move.value
  end

  def to_s
    value
  end

  protected

  VALUES = %w(rock paper scissors lizard spock)
  ACCEPTED_CHOICES = %w(r p sc l sp rock paper scissors lizard spock)
  WIN_LIST = {
    'rock' => %w(scissors lizard),
    'paper' => %w(rock spock),
    'scissors' => %w(paper lizard),
    'lizard' => %w(paper spock),
    'spock' => %w(rock scissors)
  }

  def parse_value(value)
    return value if VALUES.include? value
    case value
    when 'r'  then 'rock'
    when 'p'  then 'paper'
    when 'sc' then 'scissors'
    when 'l'  then 'lizard'
    when 'sp' then 'spock'
    end
  end
end

class Player
  include Designable

  attr_reader :move_history, :move, :name

  def initialize
    set_name
    @move_history = []
  end

  def to_s
    name.to_s
  end

  def reset
    self.move = 1
    self.move_history = []
  end

  private

  attr_writer :move_history, :move, :name

  def add_to_move_list
    move_history << move.value
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      prompt "What's your name?"
      n = read_name
      break unless n.empty?
      prompt "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      prompt "Please choose (r)ock, (p)aper, (sc)issors, (l)izard, or (sp)ock:"
      choice = read_response
      break if Move::ACCEPTED_CHOICES.include? choice
      prompt "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
    add_to_move_list
  end
end

class Computer < Player
  def initialize
    super
    @repertoir = [Move.new('rock'), Move.new('paper'), Move.new('scissors'),
                  Move.new('lizard'), Move.new('spock')]
  end

  def set_name
    self.name = self.class
  end

  def choose(previous_human_move, previous_winner)
    @previous_human_move = previous_human_move
    @previous_winner = previous_winner
    execute_strategy
    add_to_move_list
  end

  private

  attr_reader :repertoir, :previous_human_move, :previous_winner

  def execute_strategy
    if !previous_human_move        then game_start
    elsif previous_human_move == 1 then game_restart
    elsif previous_winner == self  then just_won
    elsif previous_winner          then just_lost
    else                                just_tied
    end
  end

  # Computer stretegies
  def counter(previous_move)
    repertoir.shuffle.each do |option|
      return option if option > previous_move
    end
  end

  def anticipate_counter(previous_move)
    counter(counter(previous_move))
  end

  def two_steps_ahead(previous_move)
    counter(anticipate_counter(previous_move))
  end

  def pick_random
    repertoir.sample
  end
end

class Joseph < Computer
  private

  def game_start
    self.move = pick_random
    say "Nice to meet you, I'm Joseph. How about a game?"
    say "60% of people pick rock to start with, so I will be picking #{move}."
  end

  def game_restart
    self.move = pick_random
    say "I'll play another game."
    say "I bet you know my game now, so I'll come clean.
    I'm going with #{counter(move)}."
  end

  def just_won
    self.move = two_steps_ahead(move)
    say "Oooh, you weren't expecting that now were you?"
  end

  def just_lost
    self.move = pick_random
    say "Now, I will pick #{pick_random}."
  end

  def just_tied
    self.move = pick_random
    say "Now, I will pick #{pick_random}."
  end
end

class Caesar < Computer
  private

  def game_start
    self.move = pick_random
    say "I am Caesar Anthonio Zeppeli. It is a pleasure to have this game."
  end

  def game_restart
    self.move = pick_random
    say "I am also wanting to play another game."
  end

  def just_won
    self.move = pick_random
    say "Haha!"
  end

  def just_lost
    say "As a proud member of the Zeppeli family, I shalln't lose."
  end

  def just_tied
    self.move = pick_random
    say "This is strange!"
  end
end

class Kars < Computer
  def initialize
    super
    @repertoir = [Move.new('rock'), Move.new('paper'), Move.new('scissors')]
  end

  private

  def game_start
    self.move = pick_random
    say "I am Karz. I am unfamiliar with the new version of this game."
  end

  def game_restart
    self.move = pick_random
    say "I would play another game."
  end

  def just_won
    self.move = anticipate_counter(move)
    say "Ah, so this is how one plays the game."
  end

  def just_lost
    self.move = counter(previous_human_move)
    say "Hmm, it seems there is much for me to learn on my way to perfection."
  end

  def just_tied
    self.move = pick_random
    say "I thought this variant was imposed to prevent this circumstance."
  end
end

class R2D2 < Computer
  def initialize
    super
    @repertoir = [Move.new('lizard'), Move.new('spock')]
  end

  private

  def execute_strategy
    self.move = pick_random
    say "Boop beep"
  end
end

class ScoreBoard
  include Designable

  attr_reader :winning_score, :round

  @@round = 0

  def initialize(human, computer)
    @human = human
    @computer = computer
    @score_board = {
      @human => 0,
      @computer => 0
    }
    @winning_score = play_to_what
    @round = 0
  end

  def update(round_winner)
    increment(round_winner)
    @round += 1
    display
  end

  def reset
    return unless game_over?
    @score_board = {
      @human => 0,
      @computer => 0
    }
    @round = 0
  end

  def game_over? # Maybe put tally_score out here, idk
    !!find_winner
  end

  private

  attr_accessor :score_board
  attr_reader :human, :computer

  def increment(round_winner)
    score_board[round_winner] += 1 if round_winner
  end

  def display
    prompt "#{human}: #{score_board[human]}"
    prompt "#{computer}: #{score_board[computer]}"
    prompt "GRAND WINNER: #{find_winner}" if game_over?
    new_line
  end

  def find_winner
    score_board.select { |_, score| score >= winning_score }.keys.first
  end

  def play_to_what
    prompt "How many wins would you like to play to? (Max 5)"
    answer = nil
    loop do
      answer = read_response.to_i
      break if (1..5).include? answer
      prompt "Please give an answer between 1 and 5."
    end
    answer
  end
end

# Game Orchestration Engine
class RPSGame
  include Designable

  attr_accessor :human, :computer, :round_winner, :score

  def initialize
    clear_screen
    @human = Human.new
    @computer = [Joseph.new, Caesar.new, Kars.new, R2D2.new].sample
    @score = ScoreBoard.new(human, computer)
  end

  def play
    display_welcome_message

    loop do
      play_first_to
      display_move_lists if want_move_lists?
      score.reset
      human.reset
      computer.reset
      break unless play_again?
    end

    display_goodbye_message
  end

  private

  def play_first_to
    loop do
      computer.choose(human.move, round_winner)
      human.choose
      display_moves
      assign_round_winner
      display_round_winner
      score.update(round_winner)
      break if score.game_over?
    end
  end

  def want_move_lists?
    prompt "Would you like to see the moves made during this game? (y/n)"
    answer = nil
    loop do
      answer = read_response
      break if %w(y yes n no).include? answer
      prompt %(I can only accept "y" or "n".)
    end
    return true if %w(y yes).include? answer
    false
  end

  def display_move_lists
    prompt "Here are the move lists:"
    p human.move_history
    p computer.move_history
  end

  def display_welcome_message
    clear_screen
    prompt "Welcome to RPSLS, first to #{score.winning_score}!"
  end

  def display_goodbye_message
    prompt "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_moves
    clear_screen
    prompt "You chose #{human.move}."
    prompt "#{computer.name} chose #{computer.move}."
  end

  def display_round_winner
    if round_winner == human
      prompt "You won!\n"
    elsif round_winner == computer
      prompt "#{computer} won!\n"
    else
      prompt "It's a tie!\n"
    end
    new_line
  end

  def assign_round_winner
    self.round_winner = if human.move > computer.move
                          human
                        elsif computer.move > human.move
                          computer
                        end
  end

  def play_again?
    answer = nil
    loop do
      prompt "Would you like to play again? (y/n)"
      answer = read_response
      break if ['y', 'yes', 'n', 'no'].include? answer.downcase
      prompt "Sorry, must be y or n."
    end

    clear_screen
    return true if %w(y yes).include? answer
    false
  end
end

RPSGame.new.play
