class Engine

  attr_reader :game

  def initialize(game, display)
    @game = game
    @display = display
  end

  def start
    print_introduction
    assign_symbol(@game.player1)
    play_game if @game.ready?
  end

  def restart
    @game.reset
    @display.introduction
    play_game if @game.ready?
  end

  def play_game
    @display.show(@game.board)
    while !@game.has_a_winner? && !@game.draw? do
      @display.prompt_selection(@game.turn)
      if @game.turn.class == Player
        process_mark($stdin.gets.chomp.to_i - 1)
      else
        @game.turn.mark(@game.turn.choose_move)
      end
      @display.show(@game.board)
      if (@game.has_a_winner? || @game.draw?)
        @display.announce_winner(@game.opponent) if @game.has_a_winner?
        @display.announce_draw if @game.draw?
        another_round?
      end
    end
  end

  def process_mark(position)
    @game.validate_move(position) && position >= 0 ? @game.mark(position, @game.turn) : @display.bad_move
  end

  def print_introduction
    @display.introduction
    puts ""
    @display.choose_game
    case $stdin.gets.chomp
    when "1"
      2.times{ @game.add_player(Player.new) }
      assign_name(1)
      assign_name(2)
    when "2"
      @game.add_player(Player.new)
      @game.add_player(Computer.new)
      @game.player2.name = "Tron"
      @game.player2.engine = self
      assign_name(1)
    when "3"
      2.times{ @game.add_player(Computer.new) }
      @game.player1.name = "Tron"
      @game.player2.name = "Hal"
      @game.player1.engine = self
      @game.player2.engine = self
    end
  end

  def assign_symbol(player)
    @display.mark_query(player)
    @game.player1.symbol = $stdin.gets.chomp == "1" ? "X" : "O"
    @game.player2.symbol = @game.player1.symbol == "O" ? "X" : "O"
  end

  def assign_name(player_number)
    @display.name_query(player_number)
    @game.public_send("player#{player_number}").name = $stdin.gets.chomp
  end

  def another_round?
    $stdin.gets.chomp == "y" ? restart : exit(0)
  end

end
