require 'engine'
require 'user_interface'
require 'board'
require 'game'

describe TicTacToe::Engine do

  let(:board) { TicTacToe::Board.new(3) }
  let(:output) { StringIO.new }
  let(:game) { TicTacToe::Game.new(board) }

  it "can assign a name" do
    input = StringIO.new("Nick\n")
    ui = TicTacToe::User_Interface.new(input, output)
    engine = TicTacToe::Engine.new(game, ui)
    game.human_vs_ai(ui)
    game.player2.name = "Tron"
    engine.assign_names
    expect(game.player1.name).to eq "Nick"
  end

  it "can assign a symbols" do
    input = StringIO.new("1\n")
    ui = TicTacToe::User_Interface.new(input, output)
    engine = TicTacToe::Engine.new(game, ui)
    game.human_vs_human(ui)
    engine.assign_symbols
    expect(game.player1.symbol).to eq "X"
    expect(game.player2.symbol).to eq "O"
  end

  it "can set who plays first" do
    input = StringIO.new("2\n")
    ui = TicTacToe::User_Interface.new(input, output)
    engine = TicTacToe::Engine.new(game, ui)
    game.human_vs_human(ui)
    engine.assign_symbols
    expect(game.active_player).to eq game.player2
  end


  context "gameplay" do

    it "can play a two player game" do
      input = StringIO.new("1\nNick\nRach\n1\n1\n4\n2\n5\n3\nn\n")
      ui = TicTacToe::User_Interface.new(input, output)
      engine = TicTacToe::Engine.new(game, ui)
      expect{ engine.start }.to raise_exception(SystemExit)
      expect(board.grid).to eq ["X", "X", "X", "O", "O", 6, 7, 8, 9]
    end

    it "can play a one player game" do
      input = StringIO.new("2\nNick\n1\n1\n4\n2\nn\n")
      ui = TicTacToe::User_Interface.new(input, output)
      engine = TicTacToe::Engine.new(game, ui)
      expect{ engine.start }.to raise_exception(SystemExit)
      expect(board.grid).to eq ["X", "X", "O", "X", "O", 6, "O", 8, 9]
      expect(game.has_a_winner?).to be true
    end

    it "can play an ai only game" do
      input = StringIO.new("3\n1\nn\n")
      ui = TicTacToe::User_Interface.new(input, output)
      engine = TicTacToe::Engine.new(game, ui)
      expect{ engine.start }.to raise_exception(SystemExit)
      expect(game.draw?).to be true
    end

    it "can reset the game" do
      input = StringIO.new("1\nNick\nRach\n1\n1\n4\n2\n5\n3\ny\n")
      ui = TicTacToe::User_Interface.new(input, output)
      engine = TicTacToe::Engine.new(game, ui)
      expect(engine).to receive(:restart)
      engine.start
    end
  end

end
