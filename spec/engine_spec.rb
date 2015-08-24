require 'engine'
require 'display'
require 'board'
require 'game'
require 'cell'
require 'player'

describe Engine do

  let(:board) { Board.new(Cell, 9) }
  let(:display) { Display.new }
  let(:game) { Game.new(board) }
  let(:player1) { Player.new }
  let(:player2) { Player.new }
  let(:engine) { Engine.new(game, display) }

  def setup_two_player_game
    game.add_player(player1)
    game.add_player(player2)
    player1.symbol = "X"
    player2.symbol = "O"
  end

  it "can ignore an invalid move, and prompt for a new selection" do
    setup_two_player_game
    engine.process_mark(1)
    expect{engine.process_mark(1)}.to output("Please enter a valid position.\n").to_stdout
    expect(game.turn).to eq player2
  end

end
