class Computer

  attr_accessor :symbol, :engine

  def initialize
    @choice = {}
  end

  def opponent_symbol
    @symbol == "X" ? "O" : "X"
  end

  def mark(cell)
    @engine.process_mark(cell)
  end

  def choose_move
    return @choice = 4 if @engine.game.board.empty?
    @engine.game.board.available_cells.each do |cell|
      @engine.game.board.mark(cell, @symbol)
      @choice[cell] = minimax(@engine.game.board, 1, false)
      @engine.game.board.grid[cell].content = nil
    end
    p @choice
    return @choice.max_by{|k,v| v}.first
  end

  def minimax(board, depth = 0, maximizingPlayer = true)
    return score(board, depth) if board.full? || board.has_a_winner?

    if maximizingPlayer
      bestValue = -10
      board.available_cells.each do |cell|
        board.mark(cell, @symbol)
        val = minimax(board, depth + 1, false)
        board.grid[cell].content = nil
        bestValue = [bestValue, val].max
      end
    else
      bestValue = 10
      board.available_cells.each do |cell|
        board.mark(cell, opponent_symbol)
        val = minimax(board, depth + 1, true)
        board.grid[cell].content = nil
        bestValue = [bestValue, val].min
      end
    end
    bestValue
  end

  def score(board, depth)
    return (10.0 / depth) if board.winner == @symbol
    return (-10.0 / depth) if board.winner == opponent_symbol
    return 0 if board.full?
  end

end
