require 'game'
require 'spec_helper'

describe TicTacToe::Game do

  let(:board)   { double :board, available_cells: [3, 4, 5, 6, 7, 8] }
  let(:board_win)   { double :board, has_a_winner?: true}
  let(:board_draw) { double :board, full?: true , has_a_winner?: false }
  let(:player1) { double :player, symbol: "X", name: "Nick", has_a_name?: true }
  let(:player2) { double :computer, symbol: "O" }
  let(:ui) { double :ui }
  let(:game) { TicTacToe::Game.new(board) }

  it "can be initialized as a two player game" do
    game.human_vs_human(ui)
    expect(game.player1.class).to eq TicTacToe::Player
    expect(game.player2.class).to eq TicTacToe::Player
  end

  it "can be initialized as a one player game" do
    game.human_vs_ai(ui)
    expect(game.player1.class).to eq TicTacToe::Player
    expect(game.player2.class).to eq TicTacToe::Computer
  end

  it "can be initialized as a ai only game" do
    game.ai_vs_ai(ui)
    expect(game.player2.class).to eq TicTacToe::Computer
    expect(game.player2.class).to eq TicTacToe::Computer
  end

  it "can hold a board" do
    expect(game.board).to eq board
  end

  it "can be reset" do
    expect(board).to receive(:clear)
    game.reset
  end


  context "at the beginning of the game" do

    before do
      game.human_vs_human(ui)
    end

    it "knows whos turn it is by default" do
      game.human_vs_human(ui)
      expect(game.active_player).to eq game.player1
    end

    it "can switch the active_player" do
      game.human_vs_human(ui)
      game.select_first_player(2)
      expect(game.active_player).to eq game.player2
    end

    it "knows if a player has a name" do
      expect(game.has_a_name_for?(player1)).to be true
    end

    it "can assign player names" do
      expect(player1).to receive(:name=).with("Nick")
      game.name_player(player1, "Nick")
    end

  end

  context "during play" do

    it "can initiate a player to make a choice" do
      game.human_vs_human(ui)
      game.select_first_player(1)
      expect(game.active_player).to receive(:choose_move)
      game.active_player_choose_move(board)
    end

    it "knows if a move is valid" do
      allow(board).to receive(:can_mark?).with(1).and_return(false)
      expect(game.valid_move?(1)).to be false
    end

    it "knows if a position is within range" do
      allow(board).to receive(:can_mark?).with(15).and_return(false)
      expect(game.valid_move?(15)).to be false
    end

    it "knowns when there is a winner" do
      game = TicTacToe::Game.new(player1, player2, board_win)
      expect(game).to have_a_winner
    end

    it "knows when it is a draw" do
      game = TicTacToe::Game.new(player1, player2, board_draw)
      expect(game.draw?).to be true
    end

  end


end
