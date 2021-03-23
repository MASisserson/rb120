## ROCK PAPER SCISSORS NOTES

# Classical Object Oriented Programming Steps

1. Write a textual description of the problem or exercise.
2. Pull out major nouns and verbs.
3. Organize and associate verbs to nouns.
4. Turn nouns into classes and verbs into behaviors/methods.

# Additional Steps

5. Orchestrate the flow of the program using objects instantiated
   from the classes.
      - This can be done via an 'engine' class


## RPS PLAN

*Textual Description*

Rock, Paper, Scissors is a two-player game where each player chooses
one of three possible moves: rock, paper, or scissors. The chosen moves
will then be compared to see who wins, according to the following rules:

- rock beats scissors
- scissors beats paper
- paper beats rock

If the players chose the same move, then it's a tie.

*Isolate Nouns and Verbs*

Nouns: player, move (rock, paper, scissors), rule
Verbs: choose, compare

    rock, paper, scissors can be thought of as different states of a move

*Organize and Associate*

Player
  - choose
Move
Rule

- compare

# Score Functionality

*Textual Description*

Keep a score that can be read, incremented, reset, and compared to another score.

# A Class for each Move

Each move may be either rock, paper, scissors, lizard, or spock. Each of these beats two members
of the list. Rock beats scissors and lizard, for example. Each also loses against two members of
the list. Rock loses to spock and paper, for example. Each member also ties with itself.

# Implementing a Move List

The player may want to see the move list of himself and the computer at the end of the program.
What they would potentially be looking for is patterns in the computer's play. As such, the list
should be presented as list of moves in chronological order. They need to be easily compared to
the player moves so the two should be read from left to right, one stack above the other.

They can be implemented as an array instance variable within the player class.
Whenver the players choose a move, the move is stored in the move_list

# Additional Functionality to Add

1. Clearing the screen at the right times
2. Color Coating

# Computer Personalities

Subclasses of the Computer player. When creating a new computer player, the Computer class
automatically creates a subclass that is returned (each has to have its own initialize)
method. Each computer subclass has its own playstyle.
