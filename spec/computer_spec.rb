require 'spec_helper'
require 'computer'
require 'board'

describe TicTacToe::Computer do

  let(:ui) { double :ui }
  let(:computer) { TicTacToe::Computer.new(ui) }
  let(:board) { TicTacToe::Board.new({ :length => 3 }) }
  let(:comp_win_board) { double :board, winner: "X" }
  let(:opponent_win_board) { double :board, winner: "O" }
  let(:draw_board) { double :board, full?: true, winner: false }

  before do
    computer.symbol = "X"
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

    it "will choose the a corner if playing first" do
      expect(computer.chosen_move(board)).to satisfy("be a corner") do |num|
        [0, 2, 6, 8].include? num
      end
    end

    it "will play center if the first player took a corner" do
      board = TicTacToe::Board.new({ :grid => ["O", 2, 3, 4, 5, 6, 7, 8, 9] })
      expect(computer.chosen_move(board)).to eq 4
    end

    it "will win game if option is available" do
      board = TicTacToe::Board.new({ :grid => ["X", 2, "X", 4, 5, 6, 7, 8, 9] })
      expect(computer.chosen_move(board)).to eq 1
    end

    it "will stop win game if option is available" do
      board = TicTacToe::Board.new({ :grid => [1, "O", 3, 4, 5, "O", "X", "X", "O"] })
      expect(computer.chosen_move(board)).to eq 2
    end

    it "will prevent diagonal fork" do
      board = TicTacToe::Board.new({ :grid => ["X", 2, 3, 4, "O", 6, 7, 8, "O"] })
      expect(computer.chosen_move(board)).to eq 2
    end

    it "will prevent another diagonal fork" do
      board = TicTacToe::Board.new({ :grid => ["O", 2, 3, 4, 5, "X", 7, 8, "O"] })
      expect(computer.chosen_move(board)).to eq 4
    end

    it "will prevent edge trap" do
      board = TicTacToe::Board.new({ :grid => [1, "O", 3, "O", "X", 6, 7, 8, 9] })
      expect(computer.chosen_move(board)).to eq 0
    end

    it "will prevent reverse edge trap" do
      board = TicTacToe::Board.new({ :grid => [1, 2, 3, 4, "X", "O", 7, "O", 9] })
      expect(computer.chosen_move(board)).to eq 2
    end
  end

end
