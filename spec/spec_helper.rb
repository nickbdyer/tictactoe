require 'simplecov'
SimpleCov.start

def add_two_players
  game.add_player(player1)
  game.add_player(player2)
end

def setup_two_player_game
  add_two_players
  player1.symbol = "X"
  player2.symbol = "O"
end

