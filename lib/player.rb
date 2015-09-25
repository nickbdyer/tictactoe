module TicTacToe
  #The player class is responsible for making moves, and holding individual's
  #information.
  class Player

    attr_accessor :symbol, :name
    attr_reader :interface

    def initialize(interface)
      @interface = interface
    end

    def choose_move(board)
      interface.human_move(board, self)
    end

    def has_a_name?
      name != nil
    end

    def has_a_symbol?
      symbol != nil
    end

  end
end
