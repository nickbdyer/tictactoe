class Game

  attr_reader :player1, :player2

  def initialize
    @player1, @player2 = nil, nil
  end

  def add_player(player)
    player1 ? @player2 = player : @player1 = player 
  end

  def has_two_players?
    @player1 && @player2
  end

  def turn
    turn ||= @player1
  end

end
