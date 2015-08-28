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

  def minimax(board, depth = 9, maximizingPlayer = true)
    board.debug
    return score(board) if depth == 0 || board.full? || board.has_a_winner?
    if maximizingPlayer
      bestValue = -10
      child_nodes = board.available_cells.dup
      child_nodes.each do |cell|
        mark(cell)
        child_node = board.dup
        val = minimax(child_node, depth - 1, false)
        bestValue = [bestValue, val].max
      end
      bestValue
    else
      bestValue = 10
      child_nodes = board.available_cells.dup
      child_nodes.each do |cell|
        mark(cell)
        child_node = board.dup
        val = minimax(child_node, depth - 1, true)
        bestValue = [bestValue, val].min
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
