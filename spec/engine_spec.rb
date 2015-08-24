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

  it "can ignore an invalid move, and prompt for a new selection" do
    game.add_player(player1)
    game.add_player(player2)
    player1.symbol = "X"
    engine = Engine.new(game, display)
    game.mark(1, game.turn)
    expect{engine.process_mark(1)}.to output("This square is already taken.\n").to_stdout
    expect(game.turn).to eq player2
  end

end
