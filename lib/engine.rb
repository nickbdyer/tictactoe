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
      setup_two_player_game if choice == "1"
      setup_one_player_game if choice == "2"
      setup_ai_game if choice == "3"
    end

    def setup_two_player_game
      game.human_vs_human(ui)
    end

    def setup_one_player_game
      game.human_vs_ai(ui)
    end

    def setup_ai_game
      game.ai_vs_ai(ui)
    end

    def assign_names
      game.name_player(game.player1, ui.name_query(1)) unless game.has_a_name_for?(game.player1)
      game.name_player(game.player2, ui.name_query(2)) unless game.has_a_name_for?(game.player2)
    end

    def assign_symbols
      return if game.player1.symbol
      player_one_chose_x? ? game.player1_plays_first : game.player2_plays_first
    end

    def player_one_chose_x?
      (ui.mark_query(game.player1) == "1") 
    end


  end
end
