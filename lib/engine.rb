class Engine

  def initialize(game, display)
    @game = game
    @display = display
  end

  def start
    print_introduction
    assign_symbol(@game.player1)
    play_game
  end

  def restart
    @game.reset
    @display.introduction
    play_game
  end

  def play_game
    @display.show(@game.board)
    while !@game.has_a_winner? && !@game.draw? do
      @display.prompt_selection(@game.turn)
      @game.mark((gets.chomp.to_i - 1), @game.turn)
      @display.show(@game.board)
    end
    @display.announce_winner(@game.opponent) if @game.has_a_winner?
    @display.announce_draw if @game.draw?
    gets.chomp == "y" ? restart : exit(0)
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

  def assign_symbol(player)
    @display.mark_query(player)
    @game.player1.symbol = gets.chomp == "1" ? "X" : "O"
    @game.player2.symbol = @game.player1.symbol == "O" ? "X" : "O"
  end

  def assign_name(player_number)
    @display.name_query(player_number)
    @game.public_send("player#{player_number}").name = gets.chomp
  end

end
