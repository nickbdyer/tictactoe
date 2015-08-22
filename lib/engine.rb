class Engine

  def initialize(game, board, display, player_class)
    @game = game
    @board = board
    @display = display
    @player_class = player_class
    @player1 = nil
    @player2 = nil
  end

  def start
    print_introduction
    #while !@game.has_a_winner? && @game.available_moves > 0 do
      #prompt_selection(@game.turn)
      #@board.mark(gets.chomp, @game.turn.mark)
    #end
    @display.announce_winner(@game.turn)
  end

  private

  def print_introduction
    @display.introduction
    @display.choose_game
    @display.name_query(1)
    @player1 = @player_class.new(gets.chomp)
    @display.name_query(2)
    @player2 = @player_class.new(gets.chomp)
    @display.mark_query(@player1)
  end
  
end
