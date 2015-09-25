require_relative 'player'
require_relative 'computer'

module TicTacToe
  #The game class is responsible for tictactoe logic, and player flow"
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
      select_first_player(1)
    end

    def select_first_player(player_number)
      player1.symbol, player2.symbol = "X", "O" if player_number == 1
      player1.symbol, player2.symbol = "O", "X" if player_number == 2
      @active_player = player2 if player_number == 2
    end

    def name_player(player, name)
      player.name = name
    end

    def has_a_name_for?(player)
      player.has_a_name?
    end

    def setup?
      player1.has_a_symbol?
    end

  end
end
