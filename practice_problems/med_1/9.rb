# Deck of Cards

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

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
