class Computer

  attr_accessor :symbol, :engine

  def opponent_symbol
    @symbol == "X" ? "O" : "X"
  end

  def mark(cell)
    @engine.process_mark(cell)
  end

  def choose_move
    return 4 if @engine.game.board.empty?
    evaluate_moves.max_by{|k,v| v}.first
  end

  def evaluate_moves
    options = {}
    @engine.game.board.available_cells.each do |cell|
      @engine.game.board.mark(cell, @symbol)
      options[cell] = minimax(@engine.game.board, 1, -10, 10, false)
      @engine.game.board.grid[cell].content = nil
    end
    options
  end

  def minimax(board, depth = 0, alpha = -10, beta = 10, maximizingPlayer = true)
    return score(board, depth) if board.full? || board.has_a_winner?
    if maximizingPlayer
      bestValue = -10
      board.available_cells.each do |cell|
        board.mark(cell, @symbol)
        val = minimax(board, depth + 1, alpha, beta, false)
        board.grid[cell].content = nil
        bestValue = [bestValue, val].max
        alpha = [alpha, bestValue].max
        if alpha >= beta
          break
        end
      end
    else
      bestValue = 10
      board.available_cells.each do |cell|
        board.mark(cell, opponent_symbol)
        val = minimax(board, depth + 1, alpha, beta, true)
        board.grid[cell].content = nil
        bestValue = [bestValue, val].min
        beta = [beta, bestValue].min
        if alpha >= beta
          break
        end
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
