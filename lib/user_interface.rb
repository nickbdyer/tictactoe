module TicTacToe
  class User_Interface

    attr_reader :input, :output

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

    def initialize(input = $stdin, output = $stdout)
      @input, @output = input, output
    end

    def show(board)
      output.puts CLEAR_SCREEN
      display_board = board.size == 9 ? GRIDx3.dup : GRIDx4.dup
      board.grid.each do |cell|
        display_board.sub!('#', "\e[31m#{cell}\e[0m") if cell.class == String
        display_board.sub!('#', "\e[37m#{cell}\e[0m") if cell.class == Fixnum
      end
      output.puts display_board
    end

    def introduction
      output.puts CLEAR_SCREEN
      output.puts STARS
      output.puts TITLE
      output.puts STARS
      output.puts " "
    end

    def choose_game
      output.puts "What type of game would you like to play? Press the corresponding number and <Enter>."
      output.puts "1. Human vs. Human"
      output.puts "2. Human vs. Machine"
      output.puts "3. Machine vs. Machine"
      selection = input.gets.chomp
      until ["1", "2", "3"].include? selection do
        try_choose_game_again
        selection = input.gets.chomp
      end
      selection
    end

    def try_choose_game_again
      output.puts "Don't be that guy."
      output.puts STARS
      output.puts "1. Human vs. Human"
      output.puts "2. Human vs. Machine"
      output.puts "3. Machine vs. Machine"
    end

    def name_query(number)
      output.puts "Player #{number}, what is your name?"
      input.gets.chomp
    end

    def mark_query(player)
      output.puts "#{player.name}, what mark would you like to play as?"
      output.puts "1. X (Plays first)"
      output.puts "2. O"
      input.gets.chomp
    end

    def human_move(board, player)
      output.puts "#{player.name}, it's your move, choose a cell from 1-9"
      board.mark((input.gets.chomp.to_i) - 1, player.symbol)
    end

    def computer_move(board, move, computer)
      output.puts "#{computer.name} has made a move"
      board.mark(move, computer.symbol)
    end

    def announce_winner(player)
      output.puts "#{player.name} is the winner."
      output.puts "If you'd like to play again type 'y', or any other letter to quit."
    end

    def announce_draw
      output.puts "It is a draw!"
      output.puts "If you'd like to play again type 'y', or any other letter to quit."
    end

    def bad_move
      output.puts "Please enter a valid position."
    end

    def another_round?
      input.gets.chomp == "y"
    end


  end
end
