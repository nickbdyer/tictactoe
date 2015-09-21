require 'engine'
require 'user_interface'
require 'board'
require 'game'
require 'player'
require 'computer'

describe Engine do

  let(:board) { Board.new(3) }
  let(:ui) { User_Interface.new }
  let(:game) { Game.new(board) }
  let(:player1) { Player.new(ui) }
  let(:player2) { Player.new(ui)}
  let(:engine) { Engine.new(game, ui) }

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

    it "can set who plays first" do
      $stdin = StringIO.new("n\n")
      game.add_player(player1)
      game.add_player(player2)
      engine.assign_first_player(player1)
      expect(game.turn).to eq player2
    end

  end

  context "gameplay" do

    it "can play a two player game" do
      $stdin = StringIO.new("1\nNick\nRach\n1\ny\n1\n4\n2\n5\n3\nn\n")
      expect{ engine.start }.to raise_exception(SystemExit)
      expect(board.grid).to eq ["X", "X", "X", "O", "O", 6, 7, 8, 9]
    end

    it "can play a one player game" do
      $stdin = StringIO.new("2\nNick\n1\ny\n1\n4\n2\nn\n")
      expect{ engine.start }.to raise_exception(SystemExit)
      expect(board.grid).to eq ["X", "X", "O", "X", "O", 6, "O", 8, 9]
      expect(game.has_a_winner?).to be true
    end

    it "can play an ai only game" do
      $stdin = StringIO.new("3\n1\ny\nn\n")
      expect{ engine.start }.to raise_exception(SystemExit)
      expect(game.draw?).to be true
    end

    it "can ignore an invalid move, and prompt for a new selection" do
      setup_two_player_game
      engine.process_mark(1)
      expect(ui).to receive(:bad_move)
      engine.process_mark(1)
      expect(game.turn).to eq player2
    end

    it "can reset the game" do
      $stdin = StringIO.new("1\nNick\nRach\n1\ny\n1\n4\n2\n5\n3\ny\n") # "y\n" is yes to playing another game
      expect(game).to receive(:reset)
      engine.start
    end
  end

end
