class Computer

  attr_accessor :symbol, :engine

  def opponent_symbol
    @symbol == "X" ? "O" : "X"
  end

  def mark(cell)
   @engine.process_mark(cell)
  end

  def choose_move
    chosen_cell = minimax(@engine.game.board)
    mark(chosen_cell)
  end

  def minimax(node, depth = 6, maximizingPlayer = true)
    return score(node) if depth == 0 || board.full? || board.has_a_winner?
    if maximizingPlayer
      bestValue = -10
      board.available_moves.each do |child|
        val = minimax(child, depth - 1, false)
        bestValue = [bestValue, val].max
        bestValue
      end
    else
      bestValue = 10
      board.available_moves.each do |child|
        val = minimax(child, depth - 1, true)
        bestValue = [bestValue, val].min
        bestValue
      end
    end
  end

  def score(board)
    return 10 if board.winner == @symbol
    return -10 if board.winner == opponent_symbol
    return 0 if board.full?
  end

end
