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
      game_choice = ui.choose_game
      setup_two_player_game if game_choice == "1"
      setup_one_player_game if game_choice == "2"
      setup_ai_game if game_choice == "3"
      assign_symbol(game.player1)
      ui.show(game.board)
    end

    def setup_two_player_game
      game.human_vs_human(ui)
      [1,2].each { |player| assign_name(player) }
    end

    def setup_one_player_game
      game.human_vs_ai(ui)
      game.player2.name = "Tron" 
      assign_name(1)
    end

    def setup_ai_game
      game.ai_vs_ai(ui)
      game.player1.name, game.player2.name = "Tron", "Hal 9000"
    end

    def assign_symbol(player)
      game.player1.symbol = ui.mark_query(player) == "1" ? "X" : "O"
      game.player2.symbol = game.player1.symbol == "O" ? "X" : "O"
    end

    def assign_name(player_number)
      game.public_send("player#{player_number}").name = ui.name_query(player_number)
    end

  end
end
