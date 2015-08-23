class Engine

  def initialize(game, display)
    @game = game
    @display = display
  end

  def start
    print_introduction

    #while !@game.has_a_winner? && @game.available_moves > 0 do
      #prompt_selection(@game.turn)
      #@board.mark(gets.chomp, @game.turn.mark)
    #end
  end

  private

  def print_introduction
    @display.introduction
    puts ""
    @display.choose_game
    case gets.chomp
    when "1"
      2.times{ @game.add_player(Player.new) }
      assign_name(1)
      assign_name(2)
    when "2"
      @game.add_player(Player.new)
      @game.add_player(Computer.new)
      assign_name(1)
    when "3"
      2.times{ @game.add_player(Computer.new) }
    end
  end

  def assign_name(player_number)
    @display.name_query(player_number)
    @game.public_send("player#{player_number}").name = gets.chomp
  end

end
