## Program Description

In Twenty One, there are two players, a player and a dealer, and a deck. The dealer deals 2 cards to both herself and the player at the start from the deck. From there, the player must decide whether to hit or stay. Their goal is to accumulate a hand value as close to 21 as possible without going over. The dealer then does likewise, except that they cannot stay until they have a hand value of at least 17. If either player goes over 21, they go bust and the game ends there. Before playing, the player should be given a currency amount that they can wager (the pool). The pool should be doubled with every win. Also, with each win, the player should be given the chance to sit another round or bow out. If they bow out, they keep the earnings. If they continue, they go double or nothing for the pool. The player needs to refuse twice to leave the game, once to bow out and again to leave the table with their currency.

*Nouns*
Twenty_One
Players
  Dealer
  Player
Deck
Card
Hand Value
Card Value
Personal Currency
Pool (Wagered Currency)

*Verbs*
Play
Deal
Hit
Stay
Bust
Play_again / Bow_out
Leave_table
Double pool / Lose pool

# Sorting

Deck

Card (Within Deck)
  Has: value, suit

Players
  Has: hand (Cards), hand_value, name
  Can: Bust, Hit, Stay 
  1. Dealer
      Can: Deal
  2. Player
      Has: Personal Currency
      Can: leave_table, play_again, wager, bow_out

Twenty_One
  Has: wagered_currency (pool), dealer, player, deck
  Can: start_game, double/lose pool, 

This structure immitates life well, but it has too much onus on the players. This will generate code that is hard to use in the future.

# Sorting Draft 2 (With simplified player and deck classes)

Deck
  Has: Cards
  Can: Deal, build_deck

Card
  Has: Value, Suit
  Can: display

Player
  Has: name, hand_value, hand (Cards), status (hit, stay, bust), win_point
  Can: bust, hit, stay, display_full_hand, delete_hand
  1. Human
      Has: money
      Can: wager, receive_pool
  2. Dealer
      Can: display_partial_hand

Twenty_One
  Has: player(human), player(dealer), wagered_currency (pool), deck
  Can: play, double/delete pool, Offer double_or_nothing, offer play_again, give_pool
      take_wager, request_wager, double_pool, determine_bust, determine_card_value, display_hand_value, display_partial_hand_value

This one isn't too streamlined, but it is more so. It also maintains the realism of the players posessing their own cards.
