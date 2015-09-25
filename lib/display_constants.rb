module DisplayConstants

    TITLE = "-------Welcome to TicTacToe-------"
    STARS = "*" * 34
    CLEAR_SCREEN = "\e[H\e[2J"
    GRIDx3 = <<-BOX3
    # | # | # 
   ---|---|---
    # | # | # 
   ---|---|---
    # | # | # 
    BOX3

    GRIDx4 = <<-BOX4
    # | # | # | #
   ---|---|---|---
    # | # | # | #
   ---|---|---|---
    # | # | # | #
   ---|---|---|---
    # | # | # | #
    BOX4

    GAME_TYPE_CHOICE = <<-CHOICE
What type of game would you like to play? Press the corresponding number and <Enter>.
1. Human vs. Human
2. Human vs. Machine
3. Machine vs. Machine
    CHOICE

    INSULT = "Don't be that guy."

    MARK_CHOICE = <<-MARK
1. X (Plays first)
2. O
    MARK

    ILLEGAL_MOVE = "That move is not permitted."

end
