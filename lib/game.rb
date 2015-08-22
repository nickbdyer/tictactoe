class Game

  attr_reader :player1, :player2, :board

  def initialize(board)
    @player1, @player2 = nil, nil
    @board = board
  end

  def add_player(player)
    player1 ? @player2 = player : @player1 = player 
  end

  def ready?
    @player1 != nil && @player2 != nil
  end

  def turn
    turn ||= @player1
  end

  def opponent
    turn == @player1 ? @player2 : @player1
  end

  def mark(position, player)
    @board.mark(position, player.symbol)
    turn = opponent
  end

end
