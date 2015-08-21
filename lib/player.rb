class Player

  attr_accessor :symbol, :board
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def mark_board(cell)
    @board.mark(cell, self)
  end

end
