class Player

  attr_accessor :symbol, :name
  attr_reader :interface

  def initialize(interface)
    @interface = interface
  end

  def choose_move(board)
    interface.human_move(board, self)
  end

end
