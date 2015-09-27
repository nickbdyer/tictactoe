require_relative './player'

module TicTacToe
  #The computer class is responsible for making automated moves on the board"
  class Computer < TicTacToe::Player

    NAMES = ["Tron", "Hal 9000", "Terminator"]

    attr_reader :scored_moves, :interface

    def initialize(interface)
      super
      @name = NAMES.sample
    end

    def choose_move(board)
      interface.computer_move(board, chosen_move(board), self)
    end

    private
    
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

    def opponent_symbol
      symbol == "X" ? "O" : "X"
    end

    def chosen_move(board)
      return board.corners.sample if board.empty?
      @scored_moves = {}
      negamax(board)
      scored_moves.max_by(&:last).first
    end

    def score(board, depth)
      return (10.0 / depth) if board.winner == symbol
      return (-10.0 / depth) if board.winner == opponent_symbol
      return 0 if board.full?
    end

  end
end
