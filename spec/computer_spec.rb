require 'spec_helper'
require 'computer'
require 'engine'
require 'board'
require 'game'
require 'user_interface'
require 'player'

describe TicTacToe::Computer do

  let(:ui) { User_Interface.new }
  let(:computer) { TicTacToe::Computer.new(ui) }
  let(:player) { TicTacToe::Player.new(ui) }
  let(:board) { Board.new(3) }
  let(:game) { Game.new(board) }
  let(:engine) { Engine.new(game, ui) }
  let(:comp_win_board) { double :board, winner: "X" }
  let(:opponent_win_board) { double :board, winner: "O" }
  let(:draw_board) { double :board, full?: true, winner: false }

  before do
    computer.symbol = "X"
    player.symbol = "O"
  end

  it "can have a symbol" do
    expect(computer.symbol).to eq "X"
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

  context "during a game" do

    def setup_game
      game.add_player(computer)
      game.add_player(player)
    end

    before do
      setup_game
    end


    it "will choose the top left corner if playing first" do
      expect(computer.chosen_move(board)).to eq 0
    end

    it "will play center if first player didn't" do
      board.grid = ["O", 2, 3, 4, 5, 6, 7, 8, 9]
      expect(computer.chosen_move(board)).to eq 4
    end

    it "will win game if option is available" do
      board.grid = ["X", 2, "X", 4, 5, 6, 7, 8, 9]
      expect(computer.chosen_move(board)).to eq 1
    end

    it "will stop win game if option is available" do
      board.grid = [1, "O", 3, 4, 5, "O", "X", "X", "O"]
      expect(computer.chosen_move(board)).to eq 2
    end

    it "will prevent diagonal fork" do
      board.grid = ["X", 2, 3, 4, "O", 6, 7, 8, "O"]
      expect(computer.chosen_move(board)).to eq 2
    end

    it "will prevent another diagonal fork" do
      board.grid = ["O", 2, 3, 4, 5, "X", 7, 8, "O"]
      expect(computer.chosen_move(board)).to eq 4
    end

    it "will prevent edge trap" do
      board.grid = [1, "O", 3, "O", "X", 6, 7, 8, 9]
      expect(computer.chosen_move(board)).to eq 0
    end

    it "will prevent reverse edge trap" do
      board.grid = [1, 2, 3, 4, "X", "O", 7, "O", 9]
      expect(computer.chosen_move(board)).to eq 2
    end
  end

end
