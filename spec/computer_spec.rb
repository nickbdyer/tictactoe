require 'spec_helper'
require 'computer'
require 'engine'
require 'board'
require 'game'
require 'display'
require 'player'

describe Computer do

  let(:computer) { Computer.new }
  let(:display) { Display.new }
  let(:player) { Player.new(display) }
  let(:board) { Board.new(3) }
  let(:game) { Game.new(board) }
  let(:engine) { Engine.new(game, display) }
  let(:empty_board) { double :board, available_moves: [0, 1, 2, 3, 4, 5, 6, 7, 8], winner: false, full?: false }
  let(:comp_win_board) { double :board, winner: "X" }
  let(:opponent_win_board) { double :board, winner: "O" }
  let(:draw_board) { double :board, full?: true, winner: false }

  before do
    setup_computer
  end

  it "can have an engine" do
    expect(computer.engine).to eq engine
  end

  it "can have a symbol" do
    expect(computer.symbol).to eq "X"
  end

  it "can mark the board" do
    expect(engine).to receive(:process_mark).with(3)
    computer.mark(3)
  end

  it "will choose the top left corner if playing first" do
    setup_game
    expect(computer.choose_move).to eq 0
  end

  it "will play center if first player didn't" do
    setup_game
    game.board.grid[0] = "O"
    expect(computer.choose_move).to eq 4
  end

  it "will win game if option is available" do
    setup_game
    game.board.grid[0] = "X"
    game.board.grid[2] = "X"
    expect(computer.choose_move).to eq 1
  end

  it "will stop win game if option is available" do
    setup_game
    game.board.grid[1] = "O"
    game.board.grid[5] = "O"
    game.board.grid[6] = "X"
    game.board.grid[7] = "X"
    game.board.grid[8] = "O"
    expect(computer.choose_move).to eq 2
  end

  it "will prevent diagonal fork" do
    setup_game
    game.board.grid[0] = "X"
    game.board.grid[4] = "O"
    game.board.grid[8] = "O"
    expect(computer.choose_move).to eq 2
  end

  it "will prevent another diagonal fork" do
    setup_game
    game.board.grid[0] = "O"
    game.board.grid[5] = "X"
    game.board.grid[8] = "O"
    expect(computer.choose_move).to eq 4
  end

  it "will prevent edge trap" do
    setup_game
    game.board.grid[1] = "O"
    game.board.grid[3] = "O"
    game.board.grid[4] = "X"
    expect(computer.choose_move).to eq 0
  end
 
  it "will prevent reverse edge trap" do
    setup_game
    game.board.grid[4] = "X"
    game.board.grid[5] = "O"
    game.board.grid[7] = "O"
    expect(computer.choose_move).to eq 2
  end

  it "knows what the opponents symbol is" do
    expect(computer.opponent_symbol).to eq "O"
  end

  it "will score a board with 10 if it wins" do
    expect(computer.score(comp_win_board, 1)).to eq 10
  end

  it "will score a board with -10 if it loses" do
    expect(computer.score(opponent_win_board, 1)).to eq -10
  end

  it "will score a board with 0 if it is a draw" do
    expect(computer.score(draw_board, 0)).to eq 0
  end

end
