class Computer

  attr_accessor :symbol, :engine, :name

  def initialize
    @scored_moves = {}
    @scored_moves_ab = {}
    @scored_moves_neg_ab = {}
  end

  def opponent_symbol
    @symbol == "X" ? "O" : "X"
  end

  def mark(cell)
    @engine.process_mark(cell)
  end

  def choose_move
    return 4 if @engine.game.board.empty?
    negamax(@engine.game.board)
    @scored_moves_neg_ab.max_by{|k,v| v}.first
  end

  def negamax(board, depth = 0, α = -10, β = 10, color = 1)
    return color * score(board, depth) if board.full? || board.has_a_winner?
    bestValue = -10
    board.available_cells.each do |cell|
      color == 1 ? board.mark(cell, @symbol) : board.mark(cell, opponent_symbol)
      val = -negamax(board, depth + 1, -β, -α, -color)
      board.grid[cell].content = nil
      bestValue = [bestValue, val].max
      @scored_moves_neg_ab[cell] = bestValue if depth == 0
      α = [α, bestValue].max 
      if α >= β
        break
      end
    end
    bestValue
  end

  def alphabeta(board, ai_turn = true, depth = 0, α = -10, β = 10)
    return score(board, depth) if board.full? || board.has_a_winner?
    bestValue = ai_turn ? -10 : 10
    board.available_cells.each do |cell|
      ai_turn ? board.mark(cell, @symbol) : board.mark(cell, opponent_symbol)
      val = ai_turn ? alphabeta(board, false, depth + 1, α, β) : alphabeta(board, true, depth + 1, α, β)
      board.grid[cell].content = nil
      bestValue = ai_turn ? [bestValue, val].max : [bestValue, val].min
      @scored_moves_ab[cell] = bestValue if depth == 0
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

  def minimax(board, depth = 0, alpha = -10, beta = 10, maximizingPlayer = true)
    return score(board, depth) if board.full? || board.has_a_winner?
    if maximizingPlayer
      bestValue = -10
      board.available_cells.each do |cell|
        board.mark(cell, @symbol)
        val = minimax(board, depth + 1, alpha, beta, false)
        board.grid[cell].content = nil
        bestValue = [bestValue, val].max
        @scored_moves[cell] = bestValue if depth == 0
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
        @scored_moves[cell] = bestValue if depth == 0
        beta = [beta, bestValue].min
        if alpha >= beta
          break
        end
      end
    end
    bestValue
  end

end

#def ordered_available_moves(board, depth, color)
  #hash = {}
  #board.available_cells.each do |cell|
    #color > 0 ? board.mark(cell, @symbol) : board.mark(cell, opponent_symbol)
    #hash[cell] = score(board,depth).nil? ? color * -10 : score(board,depth)
    #board.grid[cell].content = nil
  #end 
  #color > 1 ?  hash.sort_by(&:last).reverse.map(&:first) : hash.sort_by(&:last).map(&:first)
#end

#def negamax_order(board, depth = 0, α = -10, β = 10, color = 1)
  #return color * score(board, depth) if board.full? || board.has_a_winner?
  #bestValue = -10
  #ordered_available_moves(board, depth, color).each do |cell|
    #color > 0 ? board.mark(cell, @symbol) : board.mark(cell, opponent_symbol)
    #val = -negamax_order(board, depth + 1, -β, -α, -color)
    #board.grid[cell].content = nil
    #bestValue = [bestValue, val].max
    #@scored_moves_neg_order[cell] = bestValue if depth == 0
    #α = [α, bestValue].max 
    #if α >= β
      #break
    #end
  #end
  #bestValue
#end
