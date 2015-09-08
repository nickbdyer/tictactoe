class Computer

  attr_accessor :symbol, :engine, :name

  def initialize
    @scored_moves = {}
  end

  def opponent_symbol
    @symbol == "X" ? "O" : "X"
  end

  def mark(cell)
    @engine.process_mark(cell)
  end

  def choose_move
    return 4 if @engine.game.board.empty?
    alphabeta(@engine.game.board)
    @scored_moves.max_by{|k,v| v}.first
  end

  def alphabeta(board, ai_turn = true, depth = 0, α = -10, β = 10)
    return score(board, depth) if board.full? || board.has_a_winner?
    bestValue = ai_turn ? -10 : 10
    board.available_cells.each do |cell|
      ai_turn ? board.mark(cell, @symbol) : board.mark(cell, opponent_symbol)
      val = ai_turn ? alphabeta(board, false, depth + 1, α, β) : alphabeta(board, true, depth + 1, α, β)
      board.grid[cell].content = nil
      bestValue = ai_turn ? [bestValue, val].max : [bestValue, val].min
      @scored_moves[cell] = bestValue if depth == 0
      ai_turn ? α = [α, bestValue].max : β = [β, bestValue].min
      if α >= β
        break
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
