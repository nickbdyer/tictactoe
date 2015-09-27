require 'game'
require 'spec_helper'

describe TicTacToe::Game do

  let(:board)   { double :board, available_cells: [3, 4, 5, 6, 7, 8], has_a_winner?: false, full?: false }
  let(:board_win)   { double :board, full?: false, has_a_winner?: true}
  let(:board_win_and_full)   { double :board, full?: true, has_a_winner?: true}
  let(:board_draw) { double :board, full?: true , has_a_winner?: false }
  let(:new_player) { double :player, has_a_name?: false, has_a_symbol?: false }
  let(:player1) { double :player, symbol: "X", name: "Nick", has_a_name?: true, has_a_symbol?: true}
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
      expect(game.active_player).to eq game.player1
    end

    it "can switch the active_player" do
      game.select_first_player(2)
      expect(game.active_player).to eq game.player2
    end

    it "knows if a player has a name" do
      expect(game.has_a_name_for?(player1)).to be true
    end

    it "knows if a player hasn't been named" do
      expect(game.has_a_name_for?(new_player)).to be false
    end

    it "knows if player1 has a symbol" do
      game.select_first_player(1)
      expect(game.setup?).to be true
    end

    it "knows if player1 hasn't got a symbol" do
      expect(game.setup?).to be false
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

    it "knows when there is a winner" do
      game = TicTacToe::Game.new(player1, player2, board_win)
      expect(game).to have_a_winner
    end

    it "knows when there is not a winner" do
      game = TicTacToe::Game.new(player1, player2, board_draw)
      expect(game).not_to have_a_winner
    end

    it "knows when it is a draw" do
      game = TicTacToe::Game.new(player1, player2, board_draw)
      expect(game.draw?).to be true
    end

    it "knows when it is not a draw" do
      game = TicTacToe::Game.new(player1, player2, board_win)
      expect(game.draw?).to be false
    end

    it "knows when the game is over" do
      game = TicTacToe::Game.new(player1, player2, board_win)
      expect(game.ended?).to be true
    end

    it "knows when the game is not over" do
      expect(game.ended?).to be false
    end

    it "knows when there is a winner when the last move fills the board" do
      game = TicTacToe::Game.new(player1, player2, board_win_and_full)
      expect(game.draw?).to be false
      expect(game).to have_a_winner
    end

  end


end
