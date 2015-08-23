class Display

  def show(board)
    cells = board.grid.map { |cell| cell.content ? cell.content : " " }
    puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
    puts "---|---|---"
    puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
    puts "---|---|---"
    puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
  end

  def introduction
    puts "**********************************"
    puts "-------Welcome to TicTacToe-------"
    puts "**********************************"
  end

  def choose_game
    puts "What type of game would you like to play? Press the corresponding number and <Enter>."
    puts "1. Human vs. Human"
    puts "2. Human vs. Machine"
    puts "3. Machine vs. Machine"
  end

  def name_query(number)
    puts "Player #{number}, what is your name?"
  end

  def mark_query(player)
    puts "#{player.name}, what mark would you like to play as?"
    puts "1. X"
    puts "2. O"
  end

  def prompt_selection(player)
    puts "#{player.name}, it's your move, choose a cell from 1-9"
  end

  def announce_winner(player)
    puts "#{player.name} is the winner."
    puts "If you'd like to play again type 'y', or any other letter to quit."
  end

  def announce_draw
    puts "It is a draw!"
    puts "If you'd like to play again type 'y', or any other letter to quit."
  end

end
