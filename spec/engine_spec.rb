require 'engine'
require 'display'
require 'board'
require 'game'
require 'cell'
require 'player'

describe Engine do

  let(:board) { Board.new(Cell, 9) }
  let(:display) { Display.new }
  let(:game) { Game.new(board) }
  let(:player1) { Player.new }
  let(:player2) { Player.new }
  let(:engine) { Engine.new(game, display) }

  def setup_two_player_game
    game.add_player(player1)
    game.add_player(player2)
    player1.symbol = "X"
    player2.symbol = "O"
  end

  before do
    $stdout = StringIO.new
  end

  context "during setup" do

    it "can assign a name" do
      $stdin = StringIO.new("Nick\n")
      setup_two_player_game
      engine.assign_name(1)
      expect(player1.name).to eq "Nick"
    end

    it "can assign a symbol" do
      $stdin = StringIO.new("1\n")
      game.add_player(player1)
      game.add_player(player2)
      engine.assign_symbol(player1)
      expect(player1.symbol).to eq "X"
      expect(player2.symbol).to eq "O"
    end

  end

  context "gameplay" do

    it "can play a game" do
      $stdin = StringIO.new("1\nNick\nRach\n1\n1\n4\n2\n5\n3\nn\n")
      engine.start
      expect(board.grid.map { |cell| cell.content } ).to eq ["X", "X", "X", "O", "O", nil, nil, nil, nil]
    end

    it "can ignore an invalid move, and prompt for a new selection" do
      setup_two_player_game
      engine.process_mark(1)
      expect{engine.process_mark(1)}.to output("Please enter a valid position.\n").to_stdout
      expect(game.turn).to eq player2
    end

    it "can reset the game" do
      $stdin = StringIO.new("1\nNick\nRach\n1\n1\n4\n2\n5\n3\ny\n") # "y\n" is yes to playing another game
      expect(game).to receive(:reset)
      engine.start
    end
  end

end
