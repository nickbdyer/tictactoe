require 'engine'
require 'user_interface'
require 'board'
require 'game'
require 'player'
require 'computer'

describe Engine do

  let(:board) { Board.new(3) }
  let(:output) { StringIO.new }
  let(:game) { Game.new(board) }
  let(:player1) { Player.new(ui) }
  let(:player2) { Player.new(ui)}
  let(:engine) { Engine.new(game, ui) }


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

    it "can reset the game" do
      $stdin = StringIO.new("1\nNick\nRach\n1\ny\n1\n4\n2\n5\n3\ny\n")
      expect(engine).to receive(:restart)
      engine.start
    end
  end

end
