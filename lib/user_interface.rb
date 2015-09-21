class User_Interface

  attr_reader :input, :output

  def initialize(input = $stdin, output = $stdout)
    @input, @output = input, output
  end

  def show(board)
    cells = board.grid
    output.puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
    output.puts "---|---|---"
    output.puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
    output.puts "---|---|---"
    output.puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
  end

  def introduction
    output.puts "**********************************"
    output.puts "-------Welcome to TicTacToe-------"
    output.puts "**********************************"
    output.puts " "
  end

  def choose_game
    output.puts "What type of game would you like to play? Press the corresponding number and <Enter>."
    output.puts "1. Human vs. Human"
    output.puts "2. Human vs. Machine"
    output.puts "3. Machine vs. Machine"
  end

  def name_query(number)
    output.puts "Player #{number}, what is your name?"
  end

  def starting_player_query(player)
    output.puts "#{player.name}, would you like to play first? (y/n)"
  end

  def mark_query(player)
    output.puts "#{player.name}, what mark would you like to play as?"
    output.puts "1. X"
    output.puts "2. O"
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
