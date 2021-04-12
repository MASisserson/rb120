require 'pry'

module Designable
  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def red(text)
    colorize(text, 31)
  end

  def yellow(text)
    colorize(text, 33)
  end

  def prompt(text)
    puts colorize("=> #{text}", 32)
  end

  def clear_screen_prompt_new_line(text)
    clear_screen
    puts colorize("=> #{text}", 32)
    new_line
  end

  def prompt_same_line_input(text)
    print colorize("=> #{text}", 32)
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

module Validatable # Standard Version
  def yes?
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
      break if answer =~ /\A[-+]?\d+\z/
      prompt "Please input an integer."
    end
    answer.to_i
  end

  def read_integer_response_of_options(options_arr)
    answer = nil
    loop do
      answer = read_integer_response
      break if options_arr.include? answer
      prompt "Please choose #{joinor(options_arr)}."
    end
    answer
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

module Requestable
  def request_name
    system 'clear'
    prompt_same_line_input "You're name please: "
    read_string_response_greater_than 0
  end
end

class Deck
  SUITS = %w(♥ ♦ ♣ ♠)
  RANKS = %w(A 2 3 4 5 6 7 8 9 10 J Q K)

  def initialize
    reset
  end

  def deal(quantity, receiver)
    quantity.times { receiver << deck.shuffle.pop }
  end

  def reset
    @deck = []
    build_deck
  end

  private

  attr_accessor :deck

  def build_deck
    SUITS.each do |suit|
      RANKS.each do |rank|
        @deck << Card.new(suit, rank)
      end
    end
  end
end

class Card
  include Designable

  attr_reader :suit, :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def display_back
    puts " ___ "
    puts "|   |"
    puts "|???|"
    puts "|___|"
  end

  def display_front
    if %w(♥ ♦).include? suit
      red_card
    else
      black_card
    end
  end

  private

  def red_card_value
    if rank == '10'
      puts "|#{red("#{suit}#{rank}")}|"
    else
      puts "|#{red("#{suit} #{rank}")}|"
    end
  end

  def red_card
    puts " ___ "
    puts "|   |"
    red_card_value
    puts "|___|"
  end

  def black_card_value
    if rank == '10'
      puts "|#{suit}#{rank}|"
    else
      puts "|#{suit} #{rank}|"
    end
  end

  def black_card
    puts " ___ "
    puts "|   |"
    black_card_value
    puts "|___|"
  end
end

class Player
  include Comparable, Designable, Validatable

  attr_reader :name
  attr_accessor :hand, :hand_value, :stay

  def initialize(name)
    @name = name
    @hand = []
    @hand_value = 0
    @stay = false
  end

  def display_hand
    hand.each(&:display_front)
    update_hand_value
    display_hand_value
  end

  def reset
    self.hand = []
  end

  def <=>(other)
    hand_value <=> other.hand_value
  end

  def bust? # Player
    hand_value > TwentyOne::WIN_POINT
  end

  def to_s
    name
  end

  private

  def display_hand_value # Player
    new_line
    prompt "#{name}'s Hand Value: #{hand_value}."
  end

  def count_aces(cards) # Player
    cards.select { |card| card.rank == 'A' }.size
  end

  def update_hand_value # Player
    sum = 0
    hand.each { |card| sum += TwentyOne::CARD_VALUES[card.rank] }

    ace_count = count_aces(hand)

    until ace_count.zero?
      break if !bust?
      ace_count -= 1
      sum -= 10
    end

    self.hand_value = sum
  end
end

class Human < Player
  attr_accessor :money, :pool

  def initialize(name=nil)
    super
    @money = 100
    @pool = 0
  end

  def openning_wager
    return if !pool.zero?
    clear_screen
    prompt "Please make your wager."
    prompt "We accept anywhere from $1 to $20. We only operate in dollars."
    prompt "It seems you presently have #{yellow('$' + money.to_s)}"
    amount = read_integer_response_between(1, 20)
    wager amount
  end

  def update_pool(winner) # Human (Put @pool in Human)
    if winner == self
      self.pool *= 2
    else
      self.pool = 0
    end
  end

  def pay_out
    self.money += pool
    self.pool = 0
  end

  def turn(deck, dealer)
    loop do
      display_pool
      dealer.display_first_card
      display_hand
      hit_or_stay(deck)
      update_hand_value
      break if bust? || stay
    end
  end

  def hit_or_stay(deck)
    prompt "Would you like to hit?"
    return deck.deal(1, player.hand) if yes?
    self.stay = true
  end

  def loss
    clear_screen
    prompt "I am sorry for your loss."
    self.pool = 0
    prompt "You have $#{money} remaining."
  end

  def win
    clear_screen
    prompt "Here are the #{pool} dollars you have earned."
    pay_out
    prompt "This brings your total to: #{money}"
  end

  private

  attr_writer :money

  def wager(amount)
    self.money = money - amount
    self.pool += amount
  end

  def hit_or_stay(deck)
    prompt "Would you like to hit?"
    return deck.deal(1, hand) if yes?
    self.stay = true
  end

  def display_pool
    clear_screen_prompt_new_line "Pool: $#{pool}"
  end
end

class Dealer < Player
  def display_first_card
    hand.first.display_front
    hand.first.display_back
    update_hand_value
    display_hand_value
  end

  def turn(deck)
    deal_self(deck)
    loop do
      hit_or_stay(deck)
      break if bust? || stay
    end
  end

  private

  def hit_or_stay(deck) # Dealer
    if hand_value < 17
      deal_self(deck)
    else
      self.stay = true
    end
  end

  def deal_self(deck)
    deck.deal 1, hand
    update_hand_value
  end
end

class TwentyOne
  include Designable, Validatable, Requestable

  WIN_POINT = 21
  CARD_VALUES = { 'A' => 11, '2' => 2, '3' => 3, '4' => 4,
                  '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9,
                  '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10 }

  def initialize
    @deck = Deck.new
    @player = Human.new(request_name)
    @dealer = Dealer.new("Dealer")
    @pool = 0
    @winner = nil
  end

  def play
    run_intro

    loop do
      run_game

      pay_out
      break unless play_again?
    end

    display_goodbye_message
  end

  private

  attr_accessor :deck, :pool, :winner
  attr_reader :player, :dealer

  def display_welcome_message
    clear_screen
    prompt "Welcome to Twenty_One, #{player.name}."
  end

  def rules_explanation
    prompt "In this game you will be competing against the dealer."
    prompt "Your goal is to obtain a hand value closer to 21 than the dealer."
    prompt "Number cards are valued at their number."
    prompt "Face cards are valued at 10 points. The Ace is valued at 11,"
    prompt "unless your hand size would then exceed 21."
    prompt "In that case the Ace is 1 point."
  end

  def offer_rules
    prompt "Would you like to hear the rules?"
    return unless yes?
    clear_screen
    rules_explanation
    new_line
    continue_with_enter
  end

  def run_intro
    display_welcome_message
    sleep(2)
    offer_rules
  end

  def reset
    deck.reset
    player.reset
    dealer.reset
  end

  def initial_deal
    deck.deal 2, player.hand
    deck.deal 1, dealer.hand
  end

  def card_phase
    initial_deal
    player.turn(deck, dealer)
    dealer.turn(deck) if !player.bust?
  end

  def display_all_hands
    clear_screen
    dealer.display_hand
    player.display_hand
  end

  def by_bust
    if player.bust?
      self.winner = dealer
    elsif dealer.bust?
      self.winner = player
    end
  end

  def by_hand_value
    self.winner = if player > dealer
                    player
                  elsif player < dealer
                    dealer
                  end
  end

  def determine_winner
    by_hand_value if by_bust.nil?
  end

  def display_winner
    if winner
      prompt "#{winner} won!"
    else
      prompt "It was a tie!"
    end
    continue_with_enter
  end

  def results
    display_all_hands
    determine_winner
    display_winner
    player.update_pool(winner)
  end

  def dealer_won?
    winner == dealer
  end

  def double_or_nothing?
    clear_screen
    prompt "Would you like to go double or nothing?"
    yes?
  end

  def run_game
    loop do
      reset
      player.openning_wager

      card_phase

      results
      # binding.pry
      next if !winner
      break if dealer_won? || !double_or_nothing?
    end
  end

  def pay_out
    if winner == player
      player.win
    else
      player.loss
    end
  end

  def play_again?
    new_line
    prompt "Would you like to play again?"
    yes?
  end

  def display_goodbye_message
    prompt "We look forward to your patronage in the future."
  end
end

game = TwentyOne.new
game.play
