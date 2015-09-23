require 'game'
require 'spec_helper'

describe TicTacToe::Game do

  let(:board)   { double :board, available_cells: [3, 4, 5, 6, 7, 8] }
  let(:board_win)   { double :board, has_a_winner?: true}
  let(:board_draw) { double :board, full?: true , has_a_winner?: false }
  let(:player1) { double :player, symbol: "X" }
  let(:player2) { double :computer, symbol: "O" }
  let(:game) { TicTacToe::Game.new(board) }

  it "can add a player" do
    game.add_player(player1)
    expect(game.player1).to eq player1
  end

  it "can hold a board" do
    game = TicTacToe::Game.new(board)
    expect(game.board).to eq board
  end

  it "can be reset" do
    expect(board).to receive(:clear)
    game.reset
  end


  context "at the beginning of the game" do

    def add_two_players
      game.add_player(player1)
      game.add_player(player2)
    end

    it "knows whos turn it is at " do
      add_two_players
      expect(game.turn).to eq player1
    end

  end

  context "during play" do

    it "knows if a move is valid" do
      allow(board).to receive(:can_mark?).with(1).and_return(false)
      expect(game.valid_move?(1)).to be false
    end

    it "knows if a position is within range" do
      allow(board).to receive(:can_mark?).with(15).and_return(false)
      expect(game.valid_move?(15)).to be false
    end

    it "knowns when there is a winner" do
      game = TicTacToe::Game.new(board_win)
      expect(game).to have_a_winner
    end

    it "knows when it is a draw" do
      game = TicTacToe::Game.new(board_draw)
      expect(game.draw?).to be true
    end

  end


end
