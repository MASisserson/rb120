# Poker

class Card
  include Comparable

  VALUES = {
    2 => 2,
    3 => 3,
    4 => 4,
    5 => 5,
    6 => 6,
    7 => 7,
    8 => 8,
    9 => 9,
    10 => 10,
    'Jack' => 11,
    'Queen' => 12,
    'King' => 13,
    'Ace' => 14
  }

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def <=>(other)
    VALUES[rank] <=> VALUES[other.rank]
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @deck = []
    build_deck
    @deck.shuffle!
  end

  def draw
    card = @deck.pop
    reset if @deck.empty?
    card
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
        @deck << Card.new(rank, suit)
      end
    end
  end
end

# Include Card and Deck classes from the last two exercises.

class PokerHand
  attr_reader :hand
  
  def initialize(deck)
    @hand = []
    5.times do
      @hand << deck.draw
    end
    @hand.sort!
  end

  def print
    hand.each do |card|
      puts "#{card.rank} of #{card.suit}"
    end
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def ranks
    just_ranks = []
    hand.each do |card|
      just_ranks << card.rank
    end

    just_ranks
  end

  def suits
    just_suits = []
    hand.each do |card|
      just_suits << card.suit
    end

    just_suits
  end

  def royal_flush?
    ranks == [10, 'Jack', 'Queen', 'King', 'Ace'] &&
    suits.all?(suits.first)
  end

  def straight_flush?
    card_ranks = ranks
    0.upto(hand.size - 2) do |i|
      return false if !(Card::VALUES[card_ranks[i]] == Card::VALUES[card_ranks[i+1]] - 1)
    end

    return true if suits.all?(suits.first)
  end

  def four_of_a_kind?
    Deck::RANKS.each do |rank|
      return true if ranks.count(rank) == 4
    end
    false
  end

  def full_house?
    Deck::RANKS.each do |rank|
      if ranks.count(rank) == 3
        Deck::RANKS.each do |rank|
          return true if ranks.count(rank) == 2
        end
      end
    end
    false
  end

  def flush?
    suits.all? suits.first
  end

  def straight?
    card_ranks = ranks
    0.upto(hand.size - 2) do |i|
      return false if !(Card::VALUES[card_ranks[i]] == Card::VALUES[card_ranks[i+1]] - 1)
    end

    true
  end

  def three_of_a_kind?
    Deck::RANKS.each do |rank|
      return true if ranks.count(rank) == 3
    end
    false
  end

  def two_pair?
    ranks.select do |card_rank|
      ranks.count(card_rank) == 2
    end.uniq.size == 2
  end

  def pair?
    ranks.select do |card_rank|
      ranks.count(card_rank) == 2
    end.uniq.size == 1
  end
end

# hand = PokerHand.new(Deck.new)
# hand.print
# puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
