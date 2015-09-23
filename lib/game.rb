require 'player'
require 'computer'

module TicTacToe
  class Game

    attr_reader :player1, :player2, :board
    attr_writer :active_player

    def initialize(player = Player, computer = Computer, board)
      @player = player
      @computer = computer
      @board = board
    end

    def active_player
      @active_player ||= player1
    end

    def opponent
      active_player == player1 ? player2 : player1
    end

    def has_a_winner?
      board.has_a_winner?
    end

    def draw?
      board.full? && !board.has_a_winner?
    end

    def reset
      board.clear
    end

    def ended?
      has_a_winner? || draw?
    end

    def valid_move?(position)
      board.can_mark?(position) && position >= 0
    end

    def switch_players
      active_player == player1 ? @active_player = player2 : @active_player = player1
    end

    def human_vs_human(ui)
      @player1, @player2 = @player.new(ui), @player.new(ui)
    end

    def human_vs_ai(ui)
      @player1, @player2 = @player.new(ui), @computer.new(ui)
    end

    def ai_vs_ai(ui)
      @player1, @player2 = @computer.new(ui), @computer.new(ui)
    end
  end
end
