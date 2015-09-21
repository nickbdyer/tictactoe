class Engine

  attr_reader :game, :ui

  def initialize(game, ui)
    @game = game
    @ui = ui
  end

  def start
    print_introduction
    play_game if game.ready?
  end

  def play_game
    ui.show(game.board)
    until game.ended? do
      process_mark(game.turn.choose_move(game.board))
      ui.show(game.board)
    end
    ui.announce_winner(game.opponent) if game.has_a_winner?
    ui.announce_draw if game.draw?
    another_round_query
  end

  def restart
    game.reset
    ui.introduction
    play_game if game.ready?
  end

  def process_mark(position)
    return ui.bad_move unless game.valid_move?(position)
    game.mark(position, game.turn)
  end

  def print_introduction
    ui.introduction
    ui.choose_game
    case $stdin.gets.chomp
    when "1"
      setup_two_player_game
    when "2"
      setup_one_player_game
    when "3"
      setup_ai_game
    end
    assign_symbol(game.player1)
    assign_first_player(game.turn)
  end

  def setup_two_player_game
    2.times{ game.add_player(Player.new(ui)) }
    [1,2].each { |player| assign_name(player) }
  end

  def setup_one_player_game
    [Player.new(ui), Computer.new(ui)].each { |player| game.add_player(player) }
    game.player2.name = "Tron" 
    assign_name(1)
  end

  def setup_ai_game
    2.times{ game.add_player(Computer.new(ui)) }
    game.player1.name, game.player2.name = "Tron", "Hal 9000"
  end

  def assign_symbol(player)
    ui.mark_query(player)
    game.player1.symbol = $stdin.gets.chomp == "1" ? "X" : "O"
    game.player2.symbol = game.player1.symbol == "O" ? "X" : "O"
  end

  def assign_first_player(player)
    ui.starting_player_query(player)
    game.turn = $stdin.gets.chomp == "y" ? player : game.opponent
  end

  def assign_name(player_number)
    ui.name_query(player_number)
    game.public_send("player#{player_number}").name = $stdin.gets.chomp
  end

  def another_round_query
    $stdin.gets.chomp == "y" ? restart : exit(0)
  end

end
