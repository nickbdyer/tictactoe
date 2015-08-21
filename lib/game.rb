class Game

  attr_reader :player1, :player2

  def initialize
    @player1 = nil
    @player2 = nil
  end

  def add_player(player)
    player1 ? @player2 = player : @player1 = player 
  end

  def has_two_players?
    @player1 && @player2
  end

end
