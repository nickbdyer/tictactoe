module TicTacToe
  #The engine class is responsible for sequencing the game play and game setup.
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
      game.active_player_choose_move(game.board)
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

    def setup_game_type(choice)
      game.human_vs_human(ui) if choice == "1"
      game.human_vs_ai(ui) if choice == "2"
      game.ai_vs_ai(ui) if choice == "3"
    end

    def assign_names
      game.name_player(game.player1, ui.name_query(1)) unless game.has_a_name_for?(game.player1)
      game.name_player(game.player2, ui.name_query(2)) unless game.has_a_name_for?(game.player2)
    end

    def assign_symbols
      return if game.setup?
      game.select_first_player(first_player_query)
    end

    def first_player_query
      ui.mark_query(game.player1).to_i
    end


  end
end
