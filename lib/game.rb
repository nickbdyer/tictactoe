class Game

  attr_reader :player1, :player2, :board
  attr_writer :turn

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
    @turn ||= @player1
  end

  def opponent
    turn == @player1 ? @player2 : @player1
  end

  def mark(position, player)
    @board.mark(position, player.symbol)
    switch_players
  end

  def has_a_winner?
    @board.has_a_winner?
  end

  def num_available_moves
    @board.available_cells.length
  end

  def reset
    @board.clear
  end

  private

  def switch_players
    turn == @player1 ? @turn = @player2 : @turn = @player1
  end

end
