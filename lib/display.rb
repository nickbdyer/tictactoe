class Display

  def show(game)
    cells = game.grid.map { |cell| cell ||= " " }
    puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
    puts "---|---|---"
    puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
    puts "---|---|---"
    puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
  end

  def introduction
    puts "-------Welcome to TicTacToe-------"
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

end
