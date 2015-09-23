module TicTacToe
  class Engine

    attr_reader :game, :ui

    def initialize(game, ui)
      @game = game
      @ui = ui
    end

    def start
      print_introduction
      play_game
    end

    def play_game
      until game.ended? do
        make_move
      end
      ui.announce_winner(game.opponent) if game.has_a_winner?
      ui.announce_draw if game.draw?
      ui.another_round? ? restart : exit(0)
    end

    def restart
      game.reset
      ui.introduction
      ui.show(game.board)
      play_game
    end

    def make_move
      game.active_player.choose_move(game.board)
      game.switch_players
      ui.show(game.board)
    end

    def print_introduction
      ui.introduction
      setup_game_type(ui.choose_game)
      assign_names
      assign_symbols
      ui.show(game.board)
    end

    private

    def setup_game_type(choice)
      setup_two_player_game if choice == "1"
      setup_one_player_game if choice == "2"
      setup_ai_game if choice == "3"
    end

    def setup_two_player_game
      game.human_vs_human(ui)
    end

    def setup_one_player_game
      game.human_vs_ai(ui)
      game.player2.name = "Tron" 
    end

    def setup_ai_game
      game.ai_vs_ai(ui)
      game.player1.name, game.player2.name = "Tron", "Hal 9000"
      game.player1.symbol, game.player2.symbol = "X", "O"
    end

    def assign_names
      game.player1.name = ui.name_query(1) unless game.player1.name
      game.player2.name = ui.name_query(2) unless game.player2.name
    end

    def assign_symbols
      return if game.player1.symbol
      if (ui.mark_query(game.player1) == "1") 
        game.player1.symbol, game.player2.symbol = "X", "O"
      else
        game.player2.symbol, game.player1.symbol = "X", "O"
        game.active_player = game.player2
      end
    end


  end
end
