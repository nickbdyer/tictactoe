require_relative './player'

class Computer < Player

  attr_reader :scored_moves, :interface

  def initialize(interface)
    @interface = interface
    @scored_moves = {}
  end

  def opponent_symbol
    symbol == "X" ? "O" : "X"
  end

  def choose_move(board)
    interface.computer_move(chosen_move(board))
  end

  def chosen_move(board)
    @scored_moves = {}
    negamax(board)
    scored_moves.max_by(&:last).first
  end

  def negamax(board, depth = 0, α = -10, β = 10, color = 1)
    return color * score(board, depth) if board.full? || board.has_a_winner?
    bestValue = -10
    board.available_cells.each do |cell|
      color == 1 ? board.mark(cell, symbol) : board.mark(cell, opponent_symbol)
      val = -negamax(board, depth + 1, -β, -α, -color)
      board.grid[cell] = cell + 1
      bestValue = [bestValue, val].max
      scored_moves[cell] = bestValue if depth == 0
      α = [α, bestValue].max 
      if α >= β
        break
      end
    end
    bestValue
  end

  def score(board, depth)
    return (10.0 / depth) if board.winner == symbol
    return (-10.0 / depth) if board.winner == opponent_symbol
    return 0 if board.full?
  end

end
