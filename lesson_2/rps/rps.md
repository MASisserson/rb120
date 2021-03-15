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

# Additional Functionality to Add

1. Clearing the screen at the right times
2. Color Coating
