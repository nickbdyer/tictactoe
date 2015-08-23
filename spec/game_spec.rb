require 'game'
require 'spec_helper'

describe Game do

  let(:board)   { double :board, has_a_winner?: true, available_cells: [3, 4, 5, 6, 7, 8] }
  let(:player1) { double :player, symbol: "X" }
  let(:player2) { double :computer, symbol: "O" }
  let(:game) { Game.new(board) }

  def add_two_players
    game.add_player(player1)
    game.add_player(player2)
  end

  it "can add a player" do
    game.add_player(player1)
    expect(game.player1).to eq player1
  end

  it "knows when the game is ready" do
    add_two_players
    expect(game.ready?).to be true
  end

  it "can hold a board" do
    game = Game.new(board)
    expect(game.board).to eq board
  end

  it "can mark the board" do
    add_two_players
    expect(board).to receive(:mark).with(3, "X")
    game.mark(3, player1)
  end


  context "at the beginning of the game" do

    it "knows whos turn it is at " do
      add_two_players
      expect(game.turn).to eq player1
    end

  end

  context "during play" do

    it "knows whos turn it is" do
      add_two_players
      allow(board).to receive(:mark).with(3, "X")
      game.mark(3, player1)
      expect(game.turn).to eq player2
    end

    it "knows whos turn it is next" do
      add_two_players
      allow(board).to receive(:mark).with(3, "X")
      game.mark(3, player1)
      expect(game.opponent).to be player1
    end

    it "knowns when there is a winner" do
      add_two_players
      allow(board).to receive(:mark).with(0, "X")
      game.mark(0, player1)
      allow(board).to receive(:mark).with(1, "X")
      game.mark(1, player1)
      allow(board).to receive(:mark).with(2, "X")
      game.mark(2, player1)
      expect(game).to have_a_winner
    end

    it "knows how many available cells there are" do
      add_two_players
      allow(board).to receive(:mark).with(0, "X")
      game.mark(0, player1)
      allow(board).to receive(:mark).with(1, "X")
      game.mark(1, player1)
      allow(board).to receive(:mark).with(2, "X")
      game.mark(2, player1)
      expect(game.num_available_moves).to eq 6
    end

  end


end
