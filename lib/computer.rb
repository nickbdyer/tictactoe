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
    minimax(@engine.game.board)
    @choice.max_by{|k,v| v }.first
  end

  def minimax(board, depth = 9, maximizingPlayer = true)
    return score(board) if board.full? || board.has_a_winner?

    if maximizingPlayer
      bestValue = -10
      board.available_cells.each do |cell|
        board.mark(cell, @symbol)
        val = minimax(board, depth - 1, false)
        bestValue = [bestValue, val].max
        board.grid[cell].content = nil
        @choice[cell] = bestValue
      end
      bestValue
    else
      bestValue = 10
      board.available_cells.each do |cell|
        board.mark(cell, opponent_symbol)
        val = minimax(board, depth - 1, true)
        bestValue = [bestValue, val].min
        board.grid[cell].content = nil
        @choice[cell] = bestValue
      end
      bestValue
    end
  end

  def score(board)
    return 10 if board.winner == @symbol
    return -10 if board.winner == opponent_symbol
    return 0 if board.full?
  end

end
