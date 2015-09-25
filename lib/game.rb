require_relative 'player'
require_relative 'computer'

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

    def active_player_choose_move(board)
      active_player.choose_move(board)
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
      player2.name = "Tron"
    end

    def ai_vs_ai(ui)
      @player1, @player2 = @computer.new(ui), @computer.new(ui)
      player1.name, player2.name = "Tron", "Hal 9000"
      player1_plays_first
    end

    def player1_plays_first
      player1.symbol, player2.symbol = "X", "O"
    end

    def player2_plays_first
      player1.symbol, player2.symbol = "O", "X"
      @active_player = player2
    end

    def name_player(player, name)
      player.name = name
    end

    def has_a_name_for?(player)
      player.has_a_name?
    end

  end
end
